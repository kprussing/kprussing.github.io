cmake_minimum_required(VERSION 3.6.1)

project(flex-only LANGUAGES C CXX)

find_package(FLEX REQUIRED)

flex_target(lexer flex-only.l "${CMAKE_CURRENT_BINARY_DIR}/flex-only.lexer.cc")

add_executable(flex-only ${CMAKE_CURRENT_BINARY_DIR}/flex-only.lexer.cc)
target_include_directories(flex-only
    PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}
)
