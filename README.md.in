# ${PROJECT_NAME_LOWER}

A template repository for projects that link against t8code.
The project is configured such that it will build as a new library.
It includes testing with Googletest.

## Quick Start

To set up this project with your custom project name:

```bash
./setup_project.sh your_project_name
```

or manually:

```bash
cmake -P configure_project.cmake -DPROJECT_NAME_LOWER=your_project_name
```

After running the setup script:
- All template files (.in) will be processed
- The generated files will have your project name
- You can then commit these as your project


Note: Currently this project relies on t8code's PR: https://github.com/DLR-AMR/t8code/pull/2010, which is not yet merged.

## Build

After project setup, build with:

```bash
mkdir build && cd build
cmake ..
make
```

If t8code, sc or p4est are not found by CMake, you can use:

```bash
cmake -DT8CODE_DIR=path/to/T8CODEConfig.cmake -DP4EST_DIR=path/to/P4ESTConfig.cmake -DSC_DIR=path/to/SCConfig.cmake ..
```

We also recommend to use:

```bash
-DCMAKE_INSTALL_PREFIX=/path/to/install
-DCMAKE_INSTALL_LIBDIR=/path/to/install
```

when you want to locally install this package.

To install, simply call:

```bash
make install
```

## Folders and Files

### CMakeLists.txt

The basic CMake setting file.
Note that src/ and test/ folders have their own additional CMake files.

### ${PROJECT_NAME_LOWER}_main.cxx

A main program to show how to use and link against ${PROJECT_NAME_LOWER} and how to set up t8code.

### src/

Contains the source and header files of the library.

src/${PROJECT_NAME_LOWER}_helloworld.cxx and .hxx define a very simple hello world function.

### test/

Contains tests.

### thirdparty/

Contains thirdparty libraries.
This project ships with a copy of googletest-mpi which is compiled and linked to be used in tests.
In future this copy could be replaced with using FetchContent in CMake (see also https://github.com/DLR-AMR/t8code/issues/1984).
