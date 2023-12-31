; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: sed 's/iX/i32/g' %s | llc --mtriple=wasm32-unknown-unknown | FileCheck --check-prefix=I32 %s
; RUN: sed 's/iX/i64/g' %s | llc --mtriple=wasm64-unknown-unknown | FileCheck --check-prefix=I64 %s

declare iX @llvm.fshl.iX(iX, iX, iX)
declare iX @llvm.fshr.iX(iX, iX, iX)

; from https://github.com/llvm/llvm-project/issues/62703

define iX @testLeft(iX noundef %0, iX noundef %1) {
; I32-LABEL: testLeft:
; I32:         .functype testLeft (i32, i32) -> (i32)
; I32-NEXT:  # %bb.0:
; I32-NEXT:    local.get 0
; I32-NEXT:    local.get 1
; I32-NEXT:    i32.rotl
; I32-NEXT:    # fallthrough-return
;
; I64-LABEL: testLeft:
; I64:         .functype testLeft (i64, i64) -> (i64)
; I64-NEXT:  # %bb.0:
; I64-NEXT:    local.get 0
; I64-NEXT:    local.get 1
; I64-NEXT:    i64.rotl
; I64-NEXT:    # fallthrough-return
  %3 = call iX @llvm.fshl.iX(iX %0, iX %0, iX %1)
  ret iX %3
}

define iX @testRight(iX noundef %0, iX noundef %1) {
; I32-LABEL: testRight:
; I32:         .functype testRight (i32, i32) -> (i32)
; I32-NEXT:  # %bb.0:
; I32-NEXT:    local.get 0
; I32-NEXT:    local.get 1
; I32-NEXT:    i32.rotr
; I32-NEXT:    # fallthrough-return
;
; I64-LABEL: testRight:
; I64:         .functype testRight (i64, i64) -> (i64)
; I64-NEXT:  # %bb.0:
; I64-NEXT:    local.get 0
; I64-NEXT:    local.get 1
; I64-NEXT:    i64.rotr
; I64-NEXT:    # fallthrough-return
  %3 = call iX @llvm.fshr.iX(iX %0, iX %0, iX %1)
  ret iX %3
}
