//===========================================
//
// Ejemplo del uso de Open MP
//
//===========================================

#include <iostream>
#include <cmath>
#include <omp.h>


using namespace std;


int main()
{
  
  const int N = 100000; // tamaño del arreglo
  double *A = new double[N];

  cout << "Iniciando" << endl;

  #pragma omp parallel for
  for( int i=0; i<N; i++ ){
    for( int j=0; j<N; j++ )
      A[i] = 10.0/6.32*i*pow(i,3);
  }

  //for( int i=0; i<N; i++ )
  //  cout << "A["<<i<<"] = " << A[i] << endl;

  cout << "Hecho!" << endl;
  return 0;
}
