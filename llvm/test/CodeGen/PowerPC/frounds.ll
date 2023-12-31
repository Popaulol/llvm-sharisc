; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mtriple=ppc32-- | FileCheck %s \
; RUN:   -check-prefix=PPC32
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64 | FileCheck %s \
; RUN:   -check-prefix=PPC64
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64le -mattr=-direct-move \
; RUN:   | FileCheck %s -check-prefix=PPC64LE
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc64le | FileCheck %s \
; RUN:   -check-prefix=DM

define i32 @foo() {
; PPC32-LABEL: foo:
; PPC32:       # %bb.0: # %entry
; PPC32-NEXT:    stwu 1, -32(1)
; PPC32-NEXT:    .cfi_def_cfa_offset 32
; PPC32-NEXT:    mffs 0
; PPC32-NEXT:    stfd 0, 16(1)
; PPC32-NEXT:    lwz 3, 20(1)
; PPC32-NEXT:    clrlwi 4, 3, 30
; PPC32-NEXT:    not 3, 3
; PPC32-NEXT:    rlwinm 3, 3, 31, 31, 31
; PPC32-NEXT:    xor 3, 4, 3
; PPC32-NEXT:    stw 3, 24(1)
; PPC32-NEXT:    stw 3, 28(1)
; PPC32-NEXT:    addi 1, 1, 32
; PPC32-NEXT:    blr
;
; PPC64-LABEL: foo:
; PPC64:       # %bb.0: # %entry
; PPC64-NEXT:    mffs 0
; PPC64-NEXT:    stfd 0, -16(1)
; PPC64-NEXT:    lwz 3, -12(1)
; PPC64-NEXT:    clrlwi 4, 3, 30
; PPC64-NEXT:    not 3, 3
; PPC64-NEXT:    rlwinm 3, 3, 31, 31, 31
; PPC64-NEXT:    xor 3, 4, 3
; PPC64-NEXT:    stw 3, -8(1)
; PPC64-NEXT:    stw 3, -4(1)
; PPC64-NEXT:    blr
;
; PPC64LE-LABEL: foo:
; PPC64LE:       # %bb.0: # %entry
; PPC64LE-NEXT:    mffs 0
; PPC64LE-NEXT:    stfd 0, -16(1)
; PPC64LE-NEXT:    lwz 3, -16(1)
; PPC64LE-NEXT:    clrlwi 4, 3, 30
; PPC64LE-NEXT:    not 3, 3
; PPC64LE-NEXT:    rlwinm 3, 3, 31, 31, 31
; PPC64LE-NEXT:    xor 3, 4, 3
; PPC64LE-NEXT:    stw 3, -8(1)
; PPC64LE-NEXT:    stw 3, -4(1)
; PPC64LE-NEXT:    blr
;
; DM-LABEL: foo:
; DM:       # %bb.0: # %entry
; DM-NEXT:    mffs 0
; DM-NEXT:    mffprd 3, 0
; DM-NEXT:    clrlwi 4, 3, 30
; DM-NEXT:    not 3, 3
; DM-NEXT:    rlwinm 3, 3, 31, 31, 31
; DM-NEXT:    xor 3, 4, 3
; DM-NEXT:    stw 3, -8(1)
; DM-NEXT:    stw 3, -4(1)
; DM-NEXT:    blr
entry:
	%retval = alloca i32		; <ptr> [#uses=2]
	%tmp = alloca i32		; <ptr> [#uses=2]
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%tmp1 = call i32 @llvm.get.rounding( )		; <i32> [#uses=1]
	store i32 %tmp1, ptr %tmp, align 4
	%tmp2 = load i32, ptr %tmp, align 4		; <i32> [#uses=1]
	store i32 %tmp2, ptr %retval, align 4
	br label %return

return:		; preds = %entry
	%retval3 = load i32, ptr %retval		; <i32> [#uses=1]
	ret i32 %retval3
}

declare i32 @llvm.get.rounding() nounwind
