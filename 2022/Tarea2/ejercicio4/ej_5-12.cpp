// mar 04 oct 2022 10:12:10 CST
// ej_5-12.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-12.o ej_5-12.cpp
// g++ -o ej_5-12.x ej_5-12.o


// Librerias
#include <iostream>
#include <fstream>
#include <cmath>
#include <iomanip>

using namespace std;


void RK4(const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_new,
		     void (*derivada)(const double *, const double, double *));
void simple_oscilator(const double *y, const double t, double *dydt);




int main(){
  const double t0 = 0.0;
  const double y0 = 0.0;
  const double y1 = sqrt(6);
  const double h = 0.005;
  const int N = 10000;
  const int out_frec = 10;
  const int n_ec = 2;

  double t = t0;

  // espacio reservado
  double *y = new double[n_ec];
  double *y_nueva = new double[n_ec];

  void (*derivada)(const double *, const double, double *);
  derivada = simple_oscilator;

  for(int i = 0; i < n_ec; i++) y_nueva[i] = 0.0;

  y[0] = y0;
  y[1] = y1;

  cout << t << "\t" << y[0] << "\t" << y[1] << endl;

  for(int i = 0; i <= N; i++){
    RK4(y, n_ec, t, h, y_nueva, derivada);

    y = y_nueva;
    t += h;

    if (i % out_frec == 0){
      cout << t << "\t" << y[0] << "\t" << y[1] << endl;
    } // END IF
  } // END for

  return 0;
} // END main






void RK4(const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_new,
		     void (*derivada)(const double *, const double, double *)){
  double *k0 = new double[ n_ec ];
  double *k1 = new double[ n_ec ];
  double *k2 = new double[ n_ec ];
  double *k3 = new double[ n_ec ];
  double *z  = new double[ n_ec ];

  (*derivada)( y, t, k0 );

  for( int i=0; i<n_ec; i++ )
    z[i] = y[i] + 0.5*k0[i]*h;

  (*derivada)( z, t+0.5*h, k1 );

  for( int i=0; i<n_ec; i++ )
    z[i] = y[i] + 0.5*k1[i]*h;

  (*derivada)( z, t+0.5*h, k2 );

  for( int i=0; i<n_ec; i++ )
    z[i] = y[i] + k2[i]*h;

  (*derivada)( z, t+h, k3 );

  for( int i=0; i<n_ec; i++ )
   y_new[i] = y[i] + h/6.0 * ( k0[i] + 2*k1[i] + 2*k2[i] + k3[i] );

  delete[] k0;
  delete[] k1;
  delete[] k2;
  delete[] k3;
  delete[] z;
} // END RK4


void simple_oscilator(const double *y, const double t, double *dydt){
  const double l = 1;
  const double g = 1;

  dydt[0] = y[1];
  dydt[1] = -(g/l)*sin(y[0]);
} // END simple_oscilator




















//
