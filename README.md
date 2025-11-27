# t8code_project

A template repository for projects that link against t8code.
The project is configured such that it will build as a new library.
It includes testing with Googletest.

- [ ] Copy this project if you want to set up a new project using t8code.
- [ ] Replace all strings "t8project" "T8PROJECT" "t8_project" and similar with your project name. In particular in the CMake files.



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

### thirdparty/

Contains thirdparty libraries.
This project ships with a copy of googletest-mpi which is compiled and linked to be used in tests.
In future this copy could be replaced with using FetchContent in Cmake (see also https://github.com/DLR-AMR/t8code/issues/1984).
