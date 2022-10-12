#ifndef ODEINT_H
#define ODEINT_H

#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>

#include "rkqs.hpp"

#define MAXSTP 100000
#define TINY 1.0e-30
#define SIGN(a,b) ((b) >= 0.0 ? fabs(a) : -fabs(a))

using namespace std;

void odeint(double ystart[], int nvar, double x1, double x2, double eps, double h1,
	    double hmin, int *nok, int *nbad,
	    void (*derivs)(double, double [], double []),
	    void (*rkqs)(double [], double [], int, double *, double, double, double [],
			 double *, double *, void (*)(double, double [], double [])))
{
  int nstp, i;
  double x, hnext, hdid, h;
  double *yscal, *y, *dydx;

  ofstream salida;
  salida.open( "solucion.dat", ios::out );

  yscal = new double[nvar];
  y     = new double[nvar];
  dydx  = new double[nvar];
  
  x = x1;
  h = SIGN( h1, x2-x1 );
  *nok = (*nbad) = 0;
  for(i=0;i<nvar;i++) y[i]=ystart[i];
  
  for( nstp=1; nstp<=MAXSTP; nstp++ ){
    (*derivs)( x, y , dydx );
    for(i=0;i<nvar;i++)
      yscal[i]=fabs(y[i]) + fabs(dydx[i]*h) + TINY;

    /* output intermediate results */
    salida << fixed << setprecision(3) << x;
    for(i=0;i<nvar;i++)
      salida <<scientific << setprecision(9) << "\t" << y[i];
    salida << endl;
    
    if ( (x+h-x2)*(x+h-x1) > 0.0 ) h=x2-x;
    
    (*rkqs)( y, dydx, nvar, &x, h, eps, yscal, &hdid, &hnext, derivs );
    if (hdid == h) ++(*nok); else ++(*nbad);
    if ((x-x2)*(x2-x1) >= 0.0){
      for (i=1; i<=nvar; i++) ystart[i]=y[i];
      
      /* output */
      salida << fixed << setprecision(3) << x;
      for(i=0;i<nvar;i++)
	salida <<scientific << setprecision(9) << "\t" << y[i];
      salida << endl;
      
      delete[] dydx;
      delete[] y;
      delete[] yscal;
      return;
    }
    
    if (fabs(hnext) <= hmin) printf( "Step size too samll in odeint\n" );
    h = hnext;
  }
  printf( "Too many steps in routine odeint" );
}


#endif
