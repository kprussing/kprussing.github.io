cmake_minimum_required(VERSION 3.6.1)

project(parser LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 14)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

flex_target(lexer lexer.l "${CMAKE_CURRENT_BINARY_DIR}/lexer.cc")
bison_target(parser parser.y "${CMAKE_CURRENT_BINARY_DIR}/parser.cc")
add_flex_bison_dependency(lexer parser)

add_library(database SHARED
    database.cpp
    ${FLEX_lexer_OUTPUTS}
    ${BISON_parser_OUTPUTS}
)
target_include_directories(database
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
    PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}
)

add_executable(example main.cpp)
target_link_libraries(example database)

add_subdirectory(flex-only)
add_subdirectory(bison-1)
add_subdirectory(bison-2)
configure_file(example.dat
               ${CMAKE_CURRENT_BINARY_DIR}/example.dat)
configure_file(input.dat
               ${CMAKE_CURRENT_BINARY_DIR}/input.dat)
