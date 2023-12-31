; RUN: llc -mtriple=thumb-eabi < %s -o - | FileCheck %s

; Check that stack addresses are generated using a single ADD
define void @test1(ptr %p) {
  %x = alloca i8, align 1
  %y = alloca i8, align 1
  %z = alloca i8, align 1
; CHECK: add r1, sp, #8
; CHECK: str r1, [r0]
  store volatile ptr %x, ptr %p, align 4
; CHECK: add r1, sp, #4
; CHECK: str r1, [r0]
  store volatile ptr %y, ptr %p, align 4
; CHECK: mov r1, sp
; CHECK: str r1, [r0]
  store volatile ptr %z, ptr %p, align 4
  ret void
}

; Stack offsets larger than 1020 still need two ADDs
define void @test2(ptr %p) {
  %arr1 = alloca [1024 x i8], align 1
  %arr2 = alloca [1024 x i8], align 1
; CHECK: add r1, sp, #1020
; CHECK: adds r1, #4
; CHECK: str r1, [r0]
  store volatile ptr %arr1, ptr %p, align 4
; CHECK: mov r1, sp
; CHECK: str r1, [r0]
  store volatile ptr %arr2, ptr %p, align 4
  ret void
}

; If possible stack-based lrdb/ldrh are widened to use SP-based addressing
define i32 @test3() #0 {
  %x = alloca i8, align 1
  %y = alloca i8, align 1
; CHECK: ldr r0, [sp]
  %1 = load i8, ptr %x, align 1
; CHECK: ldr r1, [sp, #4]
  %2 = load i8, ptr %y, align 1
  %3 = add nsw i8 %1, %2
  %4 = zext i8 %3 to i32
  ret i32 %4
}

define i32 @test4() #0 {
  %x = alloca i16, align 2
  %y = alloca i16, align 2
; CHECK: ldr r0, [sp]
  %1 = load i16, ptr %x, align 2
; CHECK: ldr r1, [sp, #4]
  %2 = load i16, ptr %y, align 2
  %3 = add nsw i16 %1, %2
  %4 = zext i16 %3 to i32
  ret i32 %4
}

; Don't widen if the value needs to be zero-extended
define zeroext i8 @test5() {
  %x = alloca i8, align 1
; CHECK: mov r0, sp
; CHECK: ldrb r0, [r0]
  %1 = load i8, ptr %x, align 1
  ret i8 %1
}

define zeroext i16 @test6() {
  %x = alloca i16, align 2
; CHECK: mov r0, sp
; CHECK: ldrh r0, [r0]
  %1 = load i16, ptr %x, align 2
  ret i16 %1
}

; Accessing the bottom of a large array shouldn't require materializing a base
; 
; CHECK: movs [[REG:r[0-9]+]], #1
; CHECK: str [[REG]], [sp, #16]
; CHECK: str [[REG]], [sp, #4]

define void @test7() {
  %arr = alloca [200 x i32], align 4

  %arrayidx = getelementptr inbounds [200 x i32], ptr %arr, i32 0, i32 1
  store i32 1, ptr %arrayidx, align 4

  %arrayidx1 = getelementptr inbounds [200 x i32], ptr %arr, i32 0, i32 4
  store i32 1, ptr %arrayidx1, align 4

  ret void
}

; Check that loads/stores with out-of-range offsets are handled correctly
define void @test8() {
  %arr3 = alloca [224 x i32], align 4
  %arr2 = alloca [224 x i32], align 4
  %arr1 = alloca [224 x i32], align 4

; CHECK: movs [[REG:r[0-9]+]], #1
; CHECK-DAG: str [[REG]], [sp]
  store i32 1, ptr %arr1, align 4

; Offset in range for sp-based store, but not for non-sp-based store
; CHECK-DAG: str [[REG]], [sp, #128]
  %arr1idx2 = getelementptr inbounds [224 x i32], ptr %arr1, i32 0, i32 32
  store i32 1, ptr %arr1idx2, align 4

; CHECK-DAG: str [[REG]], [sp, #896]
  store i32 1, ptr %arr2, align 4

; %arr2 is in range, but this element of it is not
; CHECK-DAG: add [[RA:r[0-9]+]], sp, #900
; CHECK-DAG: str [[REG]], [{{r[0-9]+}}, #124]
  %arr2idx2 = getelementptr inbounds [224 x i32], ptr %arr2, i32 0, i32 32
  store i32 1, ptr %arr2idx2, align 4

; %arr3 is not in range
; CHECK-DAG: ldr [[RB:r[0-9]+]], .LCPI7_2
; CHECK-DAG: add [[RB]], sp
; CHECK-DAG: str [[REG]], [{{r[0-9]+}}]
  store i32 1, ptr %arr3, align 4

; CHECK-DAG: ldr [[RC:r[0-9]+]], .LCPI7_3
; CHECK-DAG: add [[RC]], sp
; CHECK-DAG: str [[REG]], [{{r[0-9]+}}]
  %arr3idx2 = getelementptr inbounds [224 x i32], ptr %arr3, i32 0, i32 32
  store i32 1, ptr %arr3idx2, align 4

  ret void
}
