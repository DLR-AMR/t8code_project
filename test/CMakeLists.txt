#  This file is part of t8project.
#  t8project is a C library to manage a collection (a forest) of multiple
#  connected adaptive space-trees of general element types in parallel.
#
#  Copyright (C) 2025 the developers
#
#  t8project is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#
#  t8project is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with t8project; if not, write to the Free Software Foundation, Inc.,
#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

add_library( gtest ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/googletest-mpi/gtest/gtest-all.cc )
target_include_directories( gtest SYSTEM PUBLIC ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/googletest-mpi ${CMAKE_CURRENT_LIST_DIR}/.. )


# Function to add a test executable and register it with CTest.
# The test executable is built from the provided source files.
function( add_t8project_test )
    set( options "" )
    set( oneValueArgs "NAME" )
    set( multiValueArgs "SOURCES" )
    cmake_parse_arguments( ADD_T8PROJECT_TEST "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    # Get the path of the first file listed in the SOURCES list and use it to determine the build directory.
    list (LENGTH ADD_T8PROJECT_TEST_SOURCES TEST_SOURCES_LENGTH)
    list(GET ADD_T8PROJECT_TEST_SOURCES 0 TEST_SOURCE)
    get_filename_component(TEST_SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/${TEST_SOURCE}" DIRECTORY)
    file(RELATIVE_PATH TEST_RELATIVE_DIR "${CMAKE_SOURCE_DIR}" "${TEST_SOURCE_DIR}")
    set(TEST_BUILD_DIR "${CMAKE_BINARY_DIR}/${TEST_RELATIVE_DIR}")

    add_executable( ${ADD_T8PROJECT_TEST_NAME} ${ADD_T8PROJECT_TEST_SOURCES} )

    # Link base libraries.
    target_include_directories( ${ADD_T8PROJECT_TEST_NAME} PRIVATE ${CMAKE_BINARY_DIR}/src )
    target_link_libraries( ${ADD_T8PROJECT_TEST_NAME} PRIVATE t8project T8CODE::T8 gtest pthread )

    set_target_properties(${ADD_T8PROJECT_TEST_NAME} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${TEST_BUILD_DIR}"
        LIBRARY_OUTPUT_DIRECTORY "${TEST_BUILD_DIR}"
        ARCHIVE_OUTPUT_DIRECTORY "${TEST_BUILD_DIR}"
    )

    # Use "mpirun -np 4" as test command
    separate_arguments (T8PROJECT_TEST_COMMAND_LIST NATIVE_COMMAND "mpirun -np 4")
    add_test( NAME ${ADD_T8PROJECT_TEST_NAME} COMMAND ${T8PROJECT_TEST_COMMAND_LIST} ${TEST_BUILD_DIR}/${ADD_T8PROJECT_TEST_NAME} )
endfunction()

# Function to add a test executable for C++ tests.
# This function wraps the `add_t8project_test` function to include common test sources.
# Common test sources are t8project_gtest_main.cpp and t8project_gtest_memory_macros.cxx
function ( add_t8project_cpp_test)
    set( options "" )
    set( oneValueArgs "NAME" )
    set( multiValueArgs "SOURCES" )
    cmake_parse_arguments( ADD_T8PROJECT_CPP_TEST "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    # add cpp sources to SOURCES list and call add_t8project_test function
    list ( APPEND ADD_T8PROJECT_CPP_TEST_SOURCES t8project_gtest_main.cxx )
    add_t8project_test( NAME ${ADD_T8PROJECT_CPP_TEST_NAME} SOURCES ${ADD_T8PROJECT_CPP_TEST_SOURCES} )
endfunction()

add_t8project_cpp_test( NAME t8project_gtest_example     SOURCES t8project_gtest_example.cxx )

