#include <t8project_helloworld.hxx>
#include <t8.h>

int
main (int argc, char **argv)
{
  int mpiret;

  /* Initialize MPI. This has to happen before we initialize sc or t8code. */
  mpiret = sc_MPI_Init (&argc, &argv);
  /* Error check the MPI return value. */
  SC_CHECK_MPI (mpiret);

  /* Initialize the sc library, has to happen before we initialize t8code. */
  sc_init (sc_MPI_COMM_WORLD, 1, 1, NULL, SC_LP_ESSENTIAL);
  /* Initialize t8code with log level SC_LP_ESSENTIAL. See sc.h for more info on the log levels. */
  t8_init (SC_LP_ESSENTIAL);

  /* Register this project as an sc package. 
   * This allows you to use sc_malloc/free.
   * You could also set up your own logging functions similar to t8_global_productionf and other, see t8.h/t8.c
   * See t8.h/t8.c for proper wrapper implementations.
   */
  t8project::helloworld();

  sc_finalize ();

  mpiret = sc_MPI_Finalize ();
  SC_CHECK_MPI (mpiret);

  return 0;
}