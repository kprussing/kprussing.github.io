cmake_minimum_required(VERSION 3.6.1)

project(bison-1 LANGUAGES C CXX)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

flex_target(lexer
    lexer.l
    ${CMAKE_CURRENT_BINARY_DIR}/lexer.lexer.cc
)
bison_target(parser
    parser.y
    ${CMAKE_CURRENT_BINARY_DIR}/parser.parser.cc
)
add_flex_bison_dependency(lexer parser)

add_executable(example-2
    ${CMAKE_CURRENT_BINARY_DIR}/lexer.lexer.cc
    ${CMAKE_CURRENT_BINARY_DIR}/parser.parser.cc
)

target_include_directories(example-2
    PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}
)

