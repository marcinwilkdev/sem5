cmake_minimum_required(VERSION 3.18)
project(project LANGUAGES CXX)

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

add_library(project srcs/project.cpp hdrs/project.hpp)
target_include_directories(project PRIVATE hdrs)

# =====

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

bison_target(parser srcs/parser.y ${PROJECT_SOURCE_DIR}/genSrcs/parser.cpp DEFINES_FILE ${PROJECT_SOURCE_DIR}/genSrcs/parser.hpp)
flex_target(lexer srcs/lexer.l ${PROJECT_SOURCE_DIR}/genSrcs/lexer.cpp DEFINES_FILE ${PROJECT_SOURCE_DIR}/genSrcs/lexer.hpp)
add_flex_bison_dependency(lexer parser)

# =====

add_executable(main srcs/main.cpp ${FLEX_lexer_OUTPUTS} ${BISON_parser_OUTPUTS})
target_include_directories(main PRIVATE hdrs)
target_link_libraries(main project)

add_executable(simpleTest test/simpleTest.cpp)
target_include_directories(simpleTest PRIVATE hdrs)
target_link_libraries(simpleTest project Catch2::Catch2WithMain)

target_code_coverage(project AUTO)
target_code_coverage(simpleTest AUTO)
