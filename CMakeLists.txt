#
# This file was copied and modified from https://cmake.org/examples/
#

# CMakeLists files in this project can
# refer to the root source directory of the project as ${T8PROJECT_SOURCE_DIR} and
# to the root binary directory of the project as ${T8PROJECT_BINARY_DIR}.
cmake_minimum_required( VERSION 3.16 )

# rudimentary version handling by setting it manually in this file
set ( T8PROJECT_VERSION_MAJOR 1 )
set ( T8PROJECT_VERSION_MINOR 0 )
set ( T8PROJECT_VERSION_PATCH 0 )

project(
  T8PROJECT
  DESCRIPTION "A template for project that link against the t8code library."
  LANGUAGES C CXX
  VERSION "${T8PROJECT_VERSION_MAJOR}.${T8PROJECT_VERSION_MINOR}.${T8PROJECT_VERSION_PATCH}"
)

# Set compilers to mpicc and mpicxx
set(CMAKE_C_COMPILER mpicc)
set(CMAKE_CXX_COMPILER mpicxx)

# Searchers for t8code build with CMake
# To add a seach path use 
#  -DT8CODE_DIR=PATH,
#  -DP4EST_DIR=PATH,
#  -DSC_DIR=PATH,
find_package ( T8CODE REQUIRED)

# Recurse into the "test" subdirectory. This does not actually
# cause another cmake executable to run. The same process will walk through
# the project's entire directory structure.
add_subdirectory (src)

# Add executable called "t8project_helloworld" that is built from the source file
# "t8project_main.cxx". The extensions are automatically found.
add_executable (t8project_helloworld t8project_main.cxx)

# Link the executable to the t8project library. Since the library has
# public include directories we will use those link directories when building
# t8project_demo.
target_link_libraries (t8project_helloworld LINK_PUBLIC t8project T8CODE::T8)

# Recurse into the "test" subdirectory. This does not actually
# cause another cmake executable to run. The same process will walk through
# the project's entire directory structure.
add_subdirectory (test)


