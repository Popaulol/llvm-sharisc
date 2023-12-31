; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt --passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu %s -o - | FileCheck %s

define i32 @main(i32 %v) {
; CHECK-LABEL: define i32 @main
; CHECK-SAME: (i32 [[V:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[V1:%.*]] = sext i1 false to i32
; CHECK-NEXT:    br i1 false, label [[IF_END11:%.*]], label [[Q41:%.*]]
; CHECK:       if.end11:
; CHECK-NEXT:    [[P1:%.*]] = phi i32 [ [[V1]], [[ENTRY:%.*]] ], [ [[P6:%.*]], [[Q41]] ], [ [[V]], [[IF_END11]] ]
; CHECK-NEXT:    [[P2:%.*]] = phi i32 [ [[V1]], [[ENTRY]] ], [ [[P6]], [[Q41]] ], [ [[V]], [[IF_END11]] ]
; CHECK-NEXT:    [[P3:%.*]] = phi i32 [ [[V1]], [[ENTRY]] ], [ [[P6]], [[Q41]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    [[P4:%.*]] = phi i32 [ [[V1]], [[ENTRY]] ], [ [[P6]], [[Q41]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    [[P5:%.*]] = phi i32 [ [[V1]], [[ENTRY]] ], [ [[P6]], [[Q41]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    [[S_14:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[S_3:%.*]], [[Q41]] ], [ [[V]], [[IF_END11]] ]
; CHECK-NEXT:    [[V_1:%.*]] = phi i32 [ undef, [[ENTRY]] ], [ [[V_4:%.*]], [[Q41]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    [[Q_1:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[Q_2:%.*]], [[Q41]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    br i1 false, label [[Q41]], label [[IF_END11]]
; CHECK:       q41:
; CHECK-NEXT:    [[P6]] = phi i32 [ [[V]], [[ENTRY]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    [[S_3]] = phi i32 [ undef, [[ENTRY]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    [[V_4]] = phi i32 [ undef, [[ENTRY]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    [[Q_2]] = phi i32 [ undef, [[ENTRY]] ], [ 0, [[IF_END11]] ]
; CHECK-NEXT:    br label [[IF_END11]]
;
entry:
  %v1 = sext i1 false to i32
  br i1 false, label %if.end11, label %q41

if.end11:
  %p1 = phi i32 [ %v1, %entry ], [ %p6, %q41 ], [ %v, %if.end11 ]
  %p2 = phi i32 [ %v1, %entry ], [ %p6, %q41 ], [ %v, %if.end11 ]
  %p3 = phi i32 [ %v1, %entry ], [ %p6, %q41 ], [ 0, %if.end11 ]
  %p4 = phi i32 [ %v1, %entry ], [ %p6, %q41 ], [ 0, %if.end11 ]
  %p5 = phi i32 [ %v1, %entry ], [ %p6, %q41 ], [ 0, %if.end11 ]
  %s.14 = phi i32 [ 0, %entry ], [ %s.3, %q41 ], [ %v, %if.end11 ]
  %v.1 = phi i32 [ undef, %entry ], [ %v.4, %q41 ], [ 0, %if.end11 ]
  %q.1 = phi i32 [ 0, %entry ], [ %q.2, %q41 ], [ 0, %if.end11 ]
  br i1 false, label %q41, label %if.end11

q41:
  %p6 = phi i32 [ %v, %entry ], [ 0, %if.end11 ]
  %s.3 = phi i32 [ undef, %entry ], [ 0, %if.end11 ]
  %v.4 = phi i32 [ undef, %entry ], [ 0, %if.end11 ]
  %q.2 = phi i32 [ undef, %entry ], [ 0, %if.end11 ]
  br label %if.end11
}
