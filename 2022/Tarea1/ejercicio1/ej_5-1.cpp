// vie 23 sep 2022 17:06:26 CST
// ej_5-1.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-1.o ej_5-1.cpp
// g++ -o ej_5-1.x ej_5-1.o


// Librerias
#include <iostream>
#include <fstream>

using namespace std;

double euler(double y, double x, double h);
double derivada(double y, double x);


int main(){
  const double y0 = 0.0;
  const double x0 = 0.0;
  const double h [4] = {0.05,0.10,0.15,0.20};
  const int N [4] = {20,10,7,5};
  ofstream salida_uno, salida_dos, salida_tres, salida_cuatro;


  double y = y0;
  double x = x0;
  double y_new = 0.0;

  // METODO DE EULER Y GENERACION DE ARCHIVOS
  salida_uno.open("h1.dat", ios::out);
  for(int i = 0; i <= N[0] - 1; i++){
    y_new = euler(y, x, h[0]);

    y = y_new;
    x = x + h[0];

    salida_uno << x << "\t" << y << endl;
  } // END FOR
  salida_uno.close();


  y = y0;
  x = x0;
  y_new = 0.0;
  salida_dos.open("h2.dat", ios::out);
  for(int i = 0; i <= N[1] - 1; i++){
    y_new = euler(y, x, h[1]);

    y = y_new;
    x = x + h[1];

    salida_dos << x << "\t" << y << endl;
  } // END FOR
  salida_dos.close();


  y = y0;
  x = x0;
  y_new = 0.0;
  salida_tres.open("h3.dat", ios::out);
  for(int i = 0; i <= N[2] - 1; i++){
    y_new = euler(y, x, h[2]);

    y = y_new;
    x = x + h[2];

    salida_tres << x << "\t" << y << endl;
  } // END FOR
  salida_tres.close();


  y = y0;
  x = x0;
  y_new = 0.0;
  salida_cuatro.open("h4.dat", ios::out);
  for(int i = 0; i <= N[3] - 1; i++){
    y_new = euler(y, x, h[3]);

    y = y_new;
    x = x + h[3];

    salida_cuatro << x << "\t" << y << endl;
  } // END FOR
  salida_cuatro.close();

  return 0;
} // END MAIN


double euler(double y, double x, double h){
  return y + h*derivada(y,x);
} // END EULER


double derivada(double y, double x){
  return y*y + 1;
} // END DERIVADA
