#!/bin/bash
# Setup Project Script
# This script provides a user-friendly interface to configure a new project
# from the template.
#
# Usage: ./setup_project.sh <project_name>
# Example: ./setup_project.sh my_awesome_library

set -e

# Check if project name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    echo ""
    echo "Example: $0 my_awesome_library"
    echo ""
    echo "This will generate all project files with the specified name"
    echo "and remove the template files."
    exit 1
fi

PROJECT_NAME="$1"

echo "=========================================="
echo "Setting up project: ${PROJECT_NAME}"
echo "=========================================="
echo ""

# Run the CMake configuration script
cmake -DPROJECT_NAME_LOWER="${PROJECT_NAME}" -P configure_project.cmake

# Check if configuration succeeded
if [ $? -eq 0 ]; then
    echo ""
    echo "Project setup complete!"
    echo ""
    echo "Generated project name: ${PROJECT_NAME}"
    echo ""
    echo "Next steps:"
    echo "  1. Review the generated files"
    echo "  2. git add ."
    echo "  3. git commit -m 'Initial project setup'"
    echo "  4. Set up your remote repository"
    echo "  5. Build with: mkdir build && cd build && cmake .. && make"
else
    echo ""
    echo "ERROR: Project setup failed!"
    exit 1
fi
