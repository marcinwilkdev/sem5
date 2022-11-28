cmake_minimum_required(VERSION 3.18)
project(second LANGUAGES CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake-scripts")

include(c++-standards)
include(code-coverage)
include(compiler-options)
include(sanitizers)
include(tools)

cxx_20()

clang_tidy()
include_what_you_use()
cppcheck()

find_package(Catch2 3 REQUIRED)

add_library(second srcs/second.cpp hdrs/second.hpp)
target_include_directories(second PRIVATE hdrs)

add_executable(main srcs/main.cpp)
target_include_directories(main PRIVATE hdrs)
target_link_libraries(main second)

add_executable(simpleTest test/simpleTest.cpp)
target_include_directories(simpleTest PRIVATE hdrs)
target_link_libraries(simpleTest second Catch2::Catch2WithMain)

target_code_coverage(second AUTO)
target_code_coverage(simpleTest AUTO)
