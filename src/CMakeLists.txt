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

# VTK dependent settings.
if( T8PROJECT_ENABLE_VTK )
    # Define T8PROJECT_VTK_MAJOR/MINOR_VERSION to true, such that get defined in t8project_vtk_linkage.hxx
    set ( T8PROJECT_VTK_MAJOR_VERSION 1 )
    set ( T8PROJECT_VTK_MINOR_VERSION 1 )
    # Set CMake variables for lib target
    target_compile_definitions( t8project PUBLIC T8PROJECT_VTK_VERSION_USED="${VTK_MAJOR_VERSION}.${VTK_MINOR_VERSION}" )
    target_compile_definitions( t8project PUBLIC T8PROJECT_ENABLE_VTK=1 )
    target_include_directories( t8project PUBLIC ${VTK_INCLUDE_DIR} )
    target_link_libraries( t8project PUBLIC ${VTK_LIBRARIES} )
    # Internal source files that need VTK linkage to compile:
#    target_sources(T8PROJECT PRIVATE
#     put/source/file/here
#    )
#    
    # Installed header files that need VTK linkage:
#    install( FILES
#     put/header/file/here
#    DESTINATION include)
else ()
    unset ( T8PROJECT_VTK_MAJOR_VERSION )
    unset ( T8PROJECT_VTK_MINOR_VERSION )
endif()

#
# Setup the file t8project_vtk_linkage.hxx and write macros for the VTK version
#
configure_file (t8project_vtk_linkage.hxx.in t8project_vtk_linkage.hxx @ONLY)


# install the automatically created t8project_vtk_linkage.hxx into the include folder
install (FILES 
    ${CMAKE_CURRENT_BINARY_DIR}/t8project_vtk_linkage.hxx
    DESTINATION include
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

#
# INSTALL section ends here
#