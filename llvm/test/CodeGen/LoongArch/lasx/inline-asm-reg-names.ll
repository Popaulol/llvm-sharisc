; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @register_xr1() nounwind {
; CHECK-LABEL: register_xr1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    #APP
; CHECK-NEXT:    xvldi $xr1, 1
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ret
entry:
  %0 = tail call <4 x i64> asm sideeffect "xvldi ${0:u}, 1", "={$xr1}"()
  ret void
}

define void @register_xr7() nounwind {
; CHECK-LABEL: register_xr7:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    #APP
; CHECK-NEXT:    xvldi $xr7, 1
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ret
entry:
  %0 = tail call <4 x i64> asm sideeffect "xvldi ${0:u}, 1", "={$xr7}"()
  ret void
}

define void @register_xr23() nounwind {
; CHECK-LABEL: register_xr23:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    #APP
; CHECK-NEXT:    xvldi $xr23, 1
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ret
entry:
  %0 = tail call <4 x i64> asm sideeffect "xvldi ${0:u}, 1", "={$xr23}"()
  ret void
}

;; The lower 64-bit of the vector register '$xr31' is overlapped with
;; the floating-point register '$f31' ('$fs7'). And '$f31' ('$fs7')
;; is a callee-saved register which is preserved across calls.
;; That's why the fst.d and fld.d instructions are emitted.
define void @register_xr31() nounwind {
; CHECK-LABEL: register_xr31:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    fst.d $fs7, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    #APP
; CHECK-NEXT:    xvldi $xr31, 1
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    fld.d $fs7, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
entry:
  %0 = tail call <4 x i64> asm sideeffect "xvldi ${0:u}, 1", "={$xr31}"()
  ret void
}
