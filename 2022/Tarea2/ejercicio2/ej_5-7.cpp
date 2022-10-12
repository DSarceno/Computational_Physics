// mar 04 oct 2022 10:08:17 CST
// ej_5-7.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-7.o ej_5-7.cpp
// g++ -o ej_5-7.x ej_5-7.o


// Librerias
#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>

// Librerias externas
#include "rkqs.hpp"
#include "odeint.hpp"

using namespace std;

void caidaLibreFriccion( double t, double *y, double *dydt );

int main(){
  int nvar, nok, nbad;
  double t1, t2, eps, h, hmin, *ystart;


  /* memory space for variables */
  // numero de ecuaciones
  nvar = 2;

  // valor inicial de cada variable
  ystart = new double[nvar];

  /* other variables initialization */
  // tolerancia (error)
  eps  = 1e-10;
  h    = 1;
  hmin = 1e-5;
  nok  = 0;
  nbad = 0;



  /* initial condition */
  ystart[0]  = 1.0;
  ystart[1]  = 0.0;

  // tiempo inicial
  t1 =  0.0;

  // tiempo final
  t2 =  2000.0;


  odeint(ystart, nvar, t1, t2, eps, h, hmin, &nok, &nbad, &caidaLibreFriccion, &rkqs);

  cout << "nok = " << nok <<"\t nbad = " << nbad << endl;

  return 0;
} // END main


void caidaLibreFriccion( double t, double *y, double *dydt ){
  const double g = 9.8;
  const double m = 0.01;
  const double k = .0001;


  dydt[0] = y[1];
  dydt[1] = m*g - (k)*y[1]*y[1];
} // END oneD_ProjectileMotion


























//
