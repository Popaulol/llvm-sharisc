//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// REQUIRES: c++03 || c++11 || c++14

// ADDITIONAL_COMPILE_FLAGS: -D_LIBCPP_DISABLE_DEPRECATION_WARNINGS

// <ios>
//
// class ios_base
// {
// public:
//     typedef T2 open_mode;
// };

//  These members were removed for C++17

#include "test_macros.h"
#include <strstream>
#include <cassert>

int main(int, char**)
{
    std::strstream::open_mode b = std::strstream::app;
    assert(b == std::ios::app);

  return 0;
}
