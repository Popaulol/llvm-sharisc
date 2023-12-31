//===-- Unittests for trunc -----------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "TruncTest.h"

#include "src/math/trunc.h"

LIST_TRUNC_TESTS(double, LIBC_NAMESPACE::trunc)
