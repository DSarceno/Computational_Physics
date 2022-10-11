// mar 04 oct 2022 10:07:55 CST
// ej_5-5.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-5.o ej_5-5.cpp
// g++ -o ej_5-5.x ej_5-5.o


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
void salidaSolucion(const double t, const double *y, const int N);
void oneD_ProjectileMotion(const double *y, const double t, double *dydt);


int main(){
  // Datos iniciales
  const double t0 = 0.0;
  const double y0 = 0.0;
  const double h = 0.1;
  const int N = 10/h; // numero de iteraciones
  const int out_frec = 1; // frecuencia de output
  const int n_ec = 1; // numero de ecuaciones

  // reservamos espacio
  double *y = new double[n_ec];
  double *y_nueva = new double[n_ec];

  // condiciones iniciales
  y[0] = y0;

  // puntero a la función derivada
  void (*derivada)(const double *, const double, double *);
  derivada = oneD_ProjectileMotion;

  // y_nueva
  y_nueva[0] = 0.0;

  double t = t0;

  cout << t << "\t" << y[0] << endl;

  for(int i = 0; i <= N; i++){
    RK4(y, n_ec, t, h, y_nueva, derivada);

    y = y_nueva;
    t += h;

    if (i % out_frec == 0){
      cout << t << "\t" << y[0] << endl;
    } // END IF
  } // END FOR


  return 0;
} // END main



void salidaSolucion(const double t, const double *y, const int n){
  cout << fixed << setprecision(3) << t;

  for(int i = 0; i < n; i++)
    cout << scientific << setprecision(9) << "\t" << y[i];

  cout << endl;
} // END salidaSolucion



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

void oneD_ProjectileMotion(const double *y, const double t, double *dydt){
  const double g = 9.8;
  const double m = 1e-2;
  const double k = 1e-4;

  // ecuaciones de movimiento
  dydt[0] = g - k*y[0]*y[0]/m;
} // END oneD_ProjectileMotion




//
