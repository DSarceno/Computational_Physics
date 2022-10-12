// mar 04 oct 2022 10:11:46 CST
// ej_5-10.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-10.o ej_5-10.cpp
// g++ -o ej_5-10.x ej_5-10.o


// Librerias
#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>

#include "rkqs.hpp"
#include "odeint.hpp"

using namespace std;


void VanderPol(double t, double *y, double *dydt);




int main(){
  int nvar, nok, nbad;
  double t1, t2, eps, h, hmin, *ystart;


  /* memory space for variables */
  // numero de ecuaciones
  nvar = 3;

  // valor inicial de cada variable
  ystart = new double[nvar];

  /* other variables initialization */
  // tolerancia (error)
  eps  = 1e-5;
  h    = 0.001;
  hmin = 1e-5;
  nok  = 0;
  nbad = 0;



  /* initial condition */
  ystart[0] = 0.5;
  ystart[1] = 0.0;
  ystart[2] = 0.0;

  // tiempo inicial
  t1 =  0.0;

  // tiempo final
  t2 =  25.12;


  odeint(ystart, nvar, t1, t2, eps, h, hmin, &nok, &nbad, &VanderPol, &rkqs);

  cout << "nok = " << nok <<"\t nbad = " << nbad << endl;

  return 0;
} // END main







void VanderPol(double t, double *y, double *dydt){
  dydt[0] = y[1];
  dydt[1] = y[2];
  dydt[2] = -y[0] - y[1]*(y[0]*y[0]-1);
} // END VanderPol


















//
