# t8code_project

A template repository for projects that link against t8code.
The project is configured such that it will build as a new library.
It includes testing with Googletest.

## Quick Start

To set up a new project with your custom project name:

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

