// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadbb -emit-llvm %s -o - \
// RUN:     -disable-O0-optnone | opt -S -passes=mem2reg \
// RUN:     | FileCheck %s  -check-prefix=RV64XTHEADBB

// RV64XTHEADBB-LABEL: @clz_32(
// RV64XTHEADBB-NEXT:  entry:
// RV64XTHEADBB-NEXT:    [[TMP0:%.*]] = call i32 @llvm.ctlz.i32(i32 [[A:%.*]], i1 false)
// RV64XTHEADBB-NEXT:    ret i32 [[TMP0]]
//
unsigned int clz_32(unsigned int a) {
  return __builtin_riscv_clz_32(a);
}

// RV64XTHEADBB-LABEL: @clo_32(
// RV64XTHEADBB-NEXT:  entry:
// RV64XTHEADBB-NEXT:    [[NOT:%.*]] = xor i32 [[A:%.*]], -1
// RV64XTHEADBB-NEXT:    [[TMP0:%.*]] = call i32 @llvm.ctlz.i32(i32 [[NOT]], i1 false)
// RV64XTHEADBB-NEXT:    ret i32 [[TMP0]]
//
unsigned int clo_32(unsigned int a) {
  return __builtin_riscv_clz_32(~a);
}

// RV64XTHEADBB-LABEL: @clz_64(
// RV64XTHEADBB-NEXT:  entry:
// RV64XTHEADBB-NEXT:    [[TMP0:%.*]] = call i64 @llvm.ctlz.i64(i64 [[A:%.*]], i1 false)
// RV64XTHEADBB-NEXT:    [[CAST:%.*]] = trunc i64 [[TMP0]] to i32
// RV64XTHEADBB-NEXT:    ret i32 [[CAST]]
//
unsigned int clz_64(unsigned long a) {
  return __builtin_riscv_clz_64(a);
}

// RV64XTHEADBB-LABEL: @clo_64(
// RV64XTHEADBB-NEXT:  entry:
// RV64XTHEADBB-NEXT:    [[NOT:%.*]] = xor i64 [[A:%.*]], -1
// RV64XTHEADBB-NEXT:    [[TMP0:%.*]] = call i64 @llvm.ctlz.i64(i64 [[NOT]], i1 false)
// RV64XTHEADBB-NEXT:    [[CAST:%.*]] = trunc i64 [[TMP0]] to i32
// RV64XTHEADBB-NEXT:    ret i32 [[CAST]]
//
unsigned int clo_64(unsigned long a) {
  return __builtin_riscv_clz_64(~a);
}
