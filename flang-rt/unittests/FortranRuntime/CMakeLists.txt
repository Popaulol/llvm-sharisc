add_flang_rt_unittest(FortranRuntimeTests
  Allocatable.cpp
  ArrayConstructor.cpp
  BufferTest.cpp
  CharacterTest.cpp
  CommandTest.cpp
  Complex.cpp
  CrashHandlerFixture.cpp
  Derived.cpp
  ExternalIOTest.cpp
  Format.cpp
  Inquiry.cpp
  ListInputTest.cpp
  LogicalFormatTest.cpp
  Matmul.cpp
  MatmulTranspose.cpp
  MiscIntrinsic.cpp
  Namelist.cpp
  Numeric.cpp
  NumericalFormatTest.cpp
  Pointer.cpp
  Ragged.cpp
  Random.cpp
  Reduction.cpp
  RuntimeCrashTest.cpp
  Stop.cpp
  Time.cpp
  TemporaryStack.cpp
  Transformational.cpp
)

target_link_libraries(FortranRuntimeTests
  PRIVATE
  flang-rt
)
