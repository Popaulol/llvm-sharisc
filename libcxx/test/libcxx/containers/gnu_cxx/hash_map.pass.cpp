//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: clang-modules-build

// Prevent <ext/hash_map> from generating deprecated warnings for this test.
// ADDITIONAL_COMPILE_FLAGS: -Wno-deprecated

#include <ext/hash_map>
#include <cassert>

#include "test_macros.h"
#include "count_new.h"

void test_default_does_not_allocate() {
  DisableAllocationGuard g;
  ((void)g);
  {
    __gnu_cxx::hash_map<int, int> h;
    assert(h.bucket_count() == 0);
  }
  {
    __gnu_cxx::hash_multimap<int, int> h;
    assert(h.bucket_count() == 0);
  }
}

int main(int, char**) {
  test_default_does_not_allocate();
  return 0;
}
