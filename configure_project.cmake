# Project Configuration Script
# This script generates a project from templates with a custom project name.
# It should be run ONCE to create a new project, then removed from the workflow.
#
# Usage:
#   cmake -D PROJECT_NAME_LOWER=your_name -P configure_project.cmake
#
# After running this script:
#   - All template files (.in) are processed and generate actual files
#   - All .in template files are removed
#   - The resulting project is ready for normal CMake builds

cmake_minimum_required(VERSION 3.16)

# Get project name from command line
if(NOT DEFINED PROJECT_NAME_LOWER)
    message(FATAL_ERROR "Please specify the project name with -D PROJECT_NAME_LOWER=your_name")
endif()

# Derive uppercase version
string(TOUPPER "${PROJECT_NAME_LOWER}" PROJECT_NAME_UPPER)

message(STATUS "Configuring project as: ${PROJECT_NAME_LOWER} / ${PROJECT_NAME_UPPER}")
message(STATUS "")

# Define all template files as a list
set(TEMPLATES
    "CMakeLists.txt.in"
    "src/CMakeLists.txt.in"
    "test/CMakeLists.txt.in"
    "README.md.in"
    "CONTRIBUTING.md.in"
    "t8project_main.cxx.in"
    "src/t8project_helloworld.cxx.in"
    "src/t8project_helloworld.hxx.in"
    "src/config.cmake.in"
    "test/t8project_gtest_main.cxx.in"
    "test/t8project_gtest_example.cxx.in"
    "test/t8project_gtest_vtk_linkage.cxx.in"
    "cmake/thirdparty.cmake.in"
)

# Define corresponding output files
set(OUTPUTS
    "CMakeLists.txt"
    "src/CMakeLists.txt"
    "test/CMakeLists.txt"
    "README.md"
    "CONTRIBUTING.md"
    "${PROJECT_NAME_LOWER}_main.cxx"
    "src/${PROJECT_NAME_LOWER}_helloworld.cxx"
    "src/${PROJECT_NAME_LOWER}_helloworld.hxx"
    "src/config.cmake.in"
    "test/${PROJECT_NAME_LOWER}_gtest_main.cxx"
    "test/${PROJECT_NAME_LOWER}_gtest_example.cxx"
    "test/${PROJECT_NAME_LOWER}_gtest_vtk_linkage.cxx"
    "cmake/thirdparty.cmake"
)

# Process each template file
list(LENGTH TEMPLATES NUM_TEMPLATES)
math(EXPR NUM_TEMPLATES "${NUM_TEMPLATES} - 1")

foreach(INDEX RANGE ${NUM_TEMPLATES})
    list(GET TEMPLATES ${INDEX} TEMPLATE_FILE)
    list(GET OUTPUTS ${INDEX} OUTPUT_FILE)
    
    # Get directory for output file
    get_filename_component(OUTPUT_DIR "${OUTPUT_FILE}" DIRECTORY)
    
    # Create directory if it doesn't exist
    if(NOT OUTPUT_DIR STREQUAL "")
        file(MAKE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${OUTPUT_DIR}")
    endif()
    
    message(STATUS "Generating: ${OUTPUT_FILE} from ${TEMPLATE_FILE}")
    
    # Use configure_file with @ONLY to only replace @VAR@ and preserve ${VAR}
    configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/${TEMPLATE_FILE}"
        "${CMAKE_CURRENT_SOURCE_DIR}/${OUTPUT_FILE}"
        @ONLY
    )
endforeach()

message(STATUS "")
message(STATUS "Removing template files (.in)")

# Find and remove all .in files in current directory and subdirectories
file(GLOB IN_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.in")
file(GLOB_RECURSE IN_FILES_RECURSE "${CMAKE_CURRENT_SOURCE_DIR}/*/*.in")
file(GLOB_RECURSE IN_FILES_RECURSE_DEEP "${CMAKE_CURRENT_SOURCE_DIR}/*/*/*.in")

# Combine all lists
set(ALL_IN_FILES ${IN_FILES} ${IN_FILES_RECURSE} ${IN_FILES_RECURSE_DEEP})

foreach(IN_FILE ${ALL_IN_FILES})
    # Get relative path

    file(RELATIVE_PATH IN_FILE_REL "${CMAKE_CURRENT_SOURCE_DIR}" "${IN_FILE}")
    # Check if this .in file is an output file. If so, we do not delete it
    list(FIND OUTPUTS ${IN_FILE_REL} found_pos)
    if(found_pos GREATER_EQUAL 0)
        # .in file is an output file, do not delete.
        message(STATUS "Skipping: ${IN_FILE_REL}")
    else()
        # delete the .in file.
        message(STATUS "Removing: ${IN_FILE_REL}")
        file(REMOVE "${IN_FILE}")
    endif()
endforeach()

# Remove the configuration scripts themselves
message(STATUS "Removing configuration scripts")
file(REMOVE "${CMAKE_CURRENT_SOURCE_DIR}/configure_project.cmake")
file(REMOVE "${CMAKE_CURRENT_SOURCE_DIR}/setup_project.sh")

message(STATUS "")
message(STATUS "========================================")
message(STATUS "Project '${PROJECT_NAME_LOWER}' generated successfully!")
message(STATUS "========================================")
message(STATUS "")
message(STATUS "Next steps:")
message(STATUS "  1. Review the generated files")
message(STATUS "  2. Initialize git (if not already): git init")
message(STATUS "  3. Add all files: git add .")
message(STATUS "  4. Commit: git commit -m 'Initial project setup'")
message(STATUS "  5. Set up your remote repository")
message(STATUS "  6. Build: mkdir build && cd build && cmake .. && make")
message(STATUS "")
