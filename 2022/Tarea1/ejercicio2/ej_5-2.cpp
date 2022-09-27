// vie 23 sep 2022 17:06:35 CST
// ej_5-2.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-2.o ej_5-2.cpp
// g++ -o ej_5-2.x ej_5-2.o


// Librerias
#include <iostream>
#include <fstream>

using namespace std;


double euler(double y, double x, double h);
double euler_modificado(double y, double x, double h);
double euler_mejorado(double y, double x, double h);
double derivada(double y, double x);


int main(){
  const double y0 = 0.0;
  const double x0 = 0.0;
  const double h = 0.10;
  const int N = 10;
  ofstream salida_simple, salida_mejorado, salida_modificado;

  double y = y0;
  double x = x0;
  double y_new = 0.0;


  salida_simple.open("simple.dat", ios::out);
  for (int i = 0; i <= N - 1; i++){
    y_new = euler(y, x, h);

    y = y_new;
    x = x + h;

    salida_simple << x << "\t" << y << endl;
  } // END FOR
  salida_simple.close();


  y = y0;
  x = x0;
  y_new = 0;
  salida_modificado.open("modificado.dat", ios::out);
  for (int i = 0; i <= N - 1; i++){
    y_new = euler_modificado(y, x, h);

    y = y_new;
    x = x + h;

    salida_modificado << x << "\t" << y << endl;
  } // END FOR
  salida_modificado.close();


  y = y0;
  x = x0;
  y_new = 0;
  salida_mejorado.open("mejorado.dat", ios::out);
  for (int i = 0; i <= N - 1; i++){
    y_new = euler_mejorado(y, x, h);

    y = y_new;
    x = x + h;

    salida_mejorado << x << "\t" << y << endl;
  } // END FOR
  salida_mejorado.close();

  return 0;
} // END MAIN

double euler(double y, double x, double h){
  return y + h*derivada(y,x);
} // END EULER

double euler_modificado(double y, double x, double h){
  double x_mid = x + 0.5*h;
  double y_mid = y + 0.5*h*derivada(y, x);
  return y + h*derivada(y_mid, x_mid);
} // END EULER_MODIFICADO

double euler_mejorado(double y, double x, double h){
  double y_tilde = y + h*derivada(y, x);
  double y_imas1 = y + 0.5*h*( derivada(y, x) + derivada(y_tilde, x + h) );
  return y_imas1;
} // END EULER_MEJORADO


double derivada(double y, double x){
  return y*y + 1;
} // END DERIVADA
