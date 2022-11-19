//============================================
//
// Pendulo doble compuesto con Runge-Kutta
// usando tamaño de paso adaptativo
//
//============================================

#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>

#include "rkqs.hpp"
#include "odeint.hpp"

using namespace std;


void pendulo_doble( double t, double *y, double *dydt );




int main()
{
  int nvar, nok, nbad;
  double t1, t2, eps, h, hmin, *ystart;


  /* memory space for variables */
  // numero de ecuaciones
  nvar = 4;

  // valor inicial de cada variable
  ystart = new double[ nvar ];

  /* other variables initialization */
  // tolerancia (error)
  eps  = 1e-10;
  h    = 1;
  hmin = 1e-20;
  nok  = 0;
  nbad = 0;

  

  /* initial condition */
  ystart[0]  = 0.5*M_PI;
  ystart[1]  = 0.5*M_PI;
  ystart[2]  = 0.0;
  ystart[3]  = 0.0;

  // tiempo inicial
  t1 =  0.0;

  // tiempo final
  t2 =  120.0;
  

  odeint( ystart, nvar, t1, t2, eps, h, hmin, &nok, &nbad, &pendulo_doble, &rkqs );

  cout << "nok = " << nok <<"\t nbad = " << nbad << endl;
  
  return 0;
}







void pendulo_doble( double t, double *y, double *dydt )
{
  const double m = 0.5; 
  const double l = 0.3; 
  const double g = 9.8;
    

  dydt[0] = 6.0/(m*l*l) * (2.0*y[2] - 3.0*y[3]*cos(y[0] - y[1]))/(16.0 - 9.0*pow(cos(y[0] - y[1]),2));
  dydt[1] = 6.0/(m*l*l) * (8.0*y[3] - 3.0*y[2]*cos(y[0] - y[1]))/(16.0 - 9.0*pow(cos(y[0] - y[1]),2));
  dydt[2] =-0.5*m*l*l   * ( dydt[0]*dydt[1]*sin(y[0] - y[1]) + 3.0*g/l*sin(y[0]));
  dydt[3] =-0.5*m*l*l   * (-dydt[0]*dydt[1]*sin(y[0] - y[1]) +  g/l*sin(y[1]));

}
