#
# This is the CMake file for the src subfolder.
# It defines the library to build.
#

# Create a library called "t8project" which includes the source files.
# The extension is already found. Any number of sources could be listed here.
add_library (t8project t8project_helloworld.cxx)

# Link library against t8code, p4est, sc
target_link_libraries (t8project PRIVATE T8CODE::T8 )

# Make sure the compiler can find include files for our t8project library
# when other libraries or executables link to t8project
target_include_directories (t8project PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Add headers files to install in /include folder
install( FILES
    t8project_helloworld.hxx
    TYPE INCLUDE
)

# Make this package available as a cmake install package, so 
# that other projects can find it with find_package.
include( CMakePackageConfigHelpers )

configure_package_config_file( ${CMAKE_CURRENT_LIST_DIR}/config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${PROJECT_NAME}Config.cmake
INSTALL_DESTINATION cmake
)

write_basic_package_version_file(
${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${PROJECT_NAME}ConfigVersion.cmake
COMPATIBILITY SameMajorVersion
VERSION "${T8PROJECT_VERSION_MAJOR}.${T8PROJECT_VERSION_MINOR}.${T8PROJECT_VERSION_PATCH}"
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/T8PROJECTConfig.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/T8PROJECTConfigVersion.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake )

install( TARGETS t8project LIBRARY )
