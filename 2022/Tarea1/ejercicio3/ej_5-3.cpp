// vie 23 sep 2022 17:06:41 CST
// ej_5-3.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-3.o ej_5-3.cpp
// g++ -o ej_5-3.x ej_5-3.o


// Librerias
#include <iostream>
#include <fstream>

using namespace std;

double euler_modificado(double y, double x, double h);
double euler_modificado2(double y, double x, double h);
double derivada(double y, double x);
double derivada2(double y, double x);


int main(){
  const double y0 = 1.0;
  const double x0 = 0.0;
  const double t0 = 0.0;
  const double h = 0.10;
  const int N = 10;
  ofstream posicion, velocidad, energia;

  double y = y0;
  double x = x0;
  double t = t0;
  double y_new = 0.0;


  velocidad.open("velocidad.dat", ios::out);
  for (int i = 0; i <= N){
    y_new = euler_modificado(y, x, h);

    y = y_new;
    x = x + h;

    velocidad <<
  } // END FOR

  return 0;
} // END MAIN


double euler_modificado(double y, double x, double h){
  double x_mid = x + 0.5*h;
  double y_mid = y + 0.5*h*derivada(y, x);
  return y + h*derivada(y_mid, x_mid);
} // END EULER_MODIFICADO

double euler_modificado2(double y, double x, double h){
  double x_mid = x + 0.5*h;
  double y_mid = y + 0.5*h*derivada(y, x);
  return y + h*derivada2(y_mid, x_mid);
} // END EULER_MODIFICADO

double derivada(double y, double x){
  return -x
} // END DERIVADA


double derivada2(double y, double x){
  return y
} // END DERIVADA
