/*
  This file is part of t8project.

  Copyright (C) 2025 the developers

  t8project is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  t8project is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with t8project; if not, write to the Free Software Foundation, Inc.,
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
*/

/* This file is modified from the t8code file test/t8_gtest_vtk_linkage.cxx as of November 2025 */

/* In this test we create a vtk unstructured Grid object and check whether
 * vtk version t8project was configured to link with is the version that is actually
 * linked.
 * The purpose of this test is to check whether t8project successfully links
 * against vtk.
 * If t8project was not configured with --enable-vtk then this test
 * does nothing and is always passed.
 */
#include <iostream>
#include <gtest/gtest.h>
#include <t8project_vtk_linkage.hxx>
#if T8PROJECT_ENABLE_VTK
#include <vtkUnstructuredGrid.h>
#include <vtkVersionMacros.h>
#include <vtkNew.h>
#endif

/* Test correct macro dependencies.
 * Will throw a compile time error if T8PROJECT_ENABLE_VTK is O
 * but T8PROJECT_VTK_VERSION_USED or T8PROJECT_VTK_MAJOR_VERSION or T8PROJECT_VTK_MINOR_VERSION is defined. */
#if not T8PROJECT_ENABLE_VTK
#ifdef T8PROJECT_VTK_VERSION_USED
#error Configuration error: T8PROJECT_VTK_VERSION_USED is defined despite \
 T8PROJECT_ENABLE_VTK not being defined.
#endif

#ifdef T8PROJECT_VTK_MAJOR_VERSION
#error Configuration error: T8PROJECT_VTK_MAJOR_VERSION is defined despite \
 T8PROJECT_ENABLE_VTK not being defined.
#endif

#ifdef T8PROJECT_VTK_MINOR_VERSION
#error Configuration error: T8PROJECT_VTK_MINOR_VERSION is defined despite \
 T8PROJECT_ENABLE_VTK not being defined.
#endif
#endif


/* Test correct macro dependencies.
 * Will throw a compile time error if T8PROJECT_ENABLE_VTK is 1
 * but one of T8PROJECT_VTK_VERSION_USED, T8PROJECT_VTK_MAJOR_VERSION, T8PROJECT_VTK_MINOR_VERSION is not defined.
 */
#if T8PROJECT_ENABLE_VTK
#ifndef T8PROJECT_VTK_VERSION_USED
#error Configuration error: T8PROJECT_ENABLE_VTK is defined despite \
 T8PROJECT_VTK_VERSION_USED not being defined.
#endif
#ifndef T8PROJECT_VTK_MAJOR_VERSION
#error Configuration error: T8PROJECT_ENABLE_VTK is defined despite \
 T8PROJECT_VTK_MAJOR_VERSION not being defined.
#endif
#ifndef T8PROJECT_VTK_MINOR_VERSION
#error Configuration error: T8PROJECT_ENABLE_VTK is defined despite \
 T8PROJECT_VTK_MINOR_VERSION not being defined.
#endif
#endif

/* Check whether T8PROJECT_VTK_VERSION_USED equals VTK_MAJOR_VERSION.VTK_MINOR_VERSION */
TEST (t8project_gtest_vtk_linkage, t8project_test_vtk_version_number)
{
#if T8PROJECT_ENABLE_VTK
  char vtk_version[BUFSIZ];
  snprintf (vtk_version, BUFSIZ, "%i.%i", VTK_MAJOR_VERSION, VTK_MINOR_VERSION);
  EXPECT_FALSE (strcmp (T8PROJECT_VTK_VERSION_USED, vtk_version))
    << "linked vtk version (" << vtk_version << ") does not equal the version t8project was configured with ("
    << T8PROJECT_VTK_VERSION_USED << ").\n";
  if (!strcmp (T8PROJECT_VTK_VERSION_USED, vtk_version)) {
    std::cout << "Using vtk version " << vtk_version << std::endl;
  }
  EXPECT_EQ (T8PROJECT_VTK_MAJOR_VERSION, VTK_MAJOR_VERSION);
  EXPECT_EQ (T8PROJECT_VTK_MINOR_VERSION, VTK_MINOR_VERSION);
#endif
}

/* Check whether we can successfully execute VTK code */
TEST (t8project_gtest_vtk_linkage, t8project_test_vtk_linkage)
{
#if T8PROJECT_ENABLE_VTK
  vtkNew<vtkUnstructuredGrid> unstructuredGrid;

  std::cout << ("Successfully created VTK unstructuredGrid object.\n");
#else
  std::cout << ("This version of t8project is not compiled with vtk support.\n");
#endif
}
