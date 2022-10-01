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

double euler_modificado(double y, double v, double t, double h);
double euler_modificado2(double y, double v, double t, double h);
double derivada(double v, double t);
double derivada2(double y, double t);
double energia(double y, double v);


int main(){
  const double y0 = 0.0;
  const double v0 = 1.0;
  const double t0 = 0.0;
  const double h = 0.10;
  const double e0 = 0.5;
  const int N = 100;
  ofstream data;

  double y = y0;
  double v = v0;
  double t = t0;
  double E = e0;
  double y_new = 0.0;
  double v_new = 0.0;
  double E_new = 0.0;


  data.open("data.dat", ios::out);
  data << t << "\t" << y << "\t" << v << "\t" << E << endl;

  for (int i = 0; i <= N; i++){
    v_new = euler_modificado(y, v, t, h);
    y_new = euler_modificado2(y, v, t, h);

    y = y_new;
    v = v_new;

    E_new = energia(y, v);
    E = E_new;

    t = t + h;

    data << t << "\t" << y << "\t" << v << "\t" << E << endl;
  } // END FOR
  data.close();

  return 0;
} // END MAIN


double euler_modificado(double y, double v, double t, double h){
  //double t_mid = t + h/2;
  //double v_mid = v - 0.5*h*derivada2(y, t);
  double y_mid = y + 0.5*h*derivada(v, t);

  return v - h*y_mid;
} // END EULER_MODIFICADO

double euler_modificado2(double y, double v, double t, double h){
  //double t_mid = t + h/2;
  double v_mid = v - 0.5*h*derivada2(y, t);
  //double y_mid = y + 0.5*h*derivada(v, t);

  return y + h*v_mid;
} // END EULER_MODIFICADO

double derivada(double v, double t){
  return v;
} // END DERIVADA


double derivada2(double y, double t){
  return -y;
} // END DERIVADA


double energia(double y, double v){
  return y*y/2 + v*v/2;
} // END ENERGIA
