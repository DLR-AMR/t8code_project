# t8code_project

A template repository for projects that link against t8code.
Copy this project if you want to set up a new project using t8code.
The project is configured such that it will build as a new library.

## Install

To build this project use

```
cmake [OPTIONS]
make
```

If t8code, sc or p4est are not found by CMake, you can use

cmake -DT8CODE_DIR=path/to/T8CODEConfig.cmake -DP4EST_DIR=path/to/P4ESTConfig.cmake -DSC_DIR=path/to/SCConfig.cmake

We also recommend to use

-DCMAKE_INSTALL_PREFIX=/path/to/install
-DCMAKE_INSTALL_LIBDIR=/path/to/install

when you want to locally install this package.

To install, simply call

`make install`

## Folders and Files

### CMakelists.txt

The basic CMake setting file.
Note that src/ and test/ folders have their own additional CMake files.

### t8project_main.cxx

A main program to show how to use and link against t8project and how to set up t8code.

### src/

Contains the source and header files of the library.

src/t8project_helloworld.cxx and .hxx define a very simple hello world function.

### test/

Contains tests.