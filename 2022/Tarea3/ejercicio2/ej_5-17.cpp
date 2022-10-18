// vie 14 oct 2022 17:26:04 CST
// ej_5-17.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_5-17.o ej_5-17.cpp
// g++ -o ej_5-17.x ej_5-17.o


// Librerias
#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>

using namespace std;

void RK4(const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
	             void (*derivada)( const double *, const double, double *));
void salidaSolucion(const double t, const double *y, const int N);
void spaceCraft(const double *y, const double t, double *dydt);


int main(){
  const double t0 = 0.0;
  const double h = 0.1;
  const int N = 180000; //48e6
  const int frec_out = 5000;
  const int n_ec = 12;
  const int alpha = 0;


  // espacio de y
  double *y = new double[n_ec];
  double *y_nueva = new double[n_ec];

  // condiciones iniciales
  y[0] = 0.0;
  y[1] = 0.0;
  y[2] = 3.844e8;
  y[3] = 0.0;
  y[4] = (6.8e6)*cos(alpha);
  y[5] = (6.8e6)*sin(alpha);
  y[6] = 0.0;
  y[7] = 0.0;
  y[8] = 0.0;
  y[9] = 1000;
  y[10] = (25000)*cos(0.04 + alpha);
  y[11] = (25000)*sin(0.04 + alpha);

  // puntero a la 'derivada'
  void (*derivada)( const double *, const double, double * );
  derivada = spaceCraft;


  // incializar y_nueva
  for(int i = 0; i < n_ec; i++) y_nueva[i] = 0.0;

  double t = t0;

  // escribir las condiciones iniciales en el programa y la descripcion de las columnas de Datos
  cout << "# Columna 1: Tiempo" << endl;
  cout << "# Columna 2: Tierra-x" << endl;
  cout << "# Columna 3: Tierra-y" << endl;
  cout << "# Columna 4: Luna-x" << endl;
  cout << "# Columna 5: Luna-y" << endl;
  cout << "# Columna 6: Nave-x" << endl;
  cout << "# Columna 7: Nave-y" << endl;
  cout << "# Columna 8: Tierra-v-x" << endl;
  cout << "# Columna 9: Tierra-v-y" << endl;
  cout << "# Columna 10: Luna-v-x" << endl;
  cout << "# Columna 11: Luna-v-y" << endl;
  cout << "# Columna 12: Nave-v-x" << endl;
  cout << "# Columna 13: Nave-v-y" << endl;


  salidaSolucion(t, y, n_ec);

  for(int i = 1; i <= N; i++){
    RK4(y, n_ec, t, h, y_nueva, derivada);

    y = y_nueva;
    t += h;

    if (i % frec_out == 0){
      salidaSolucion(t, y, n_ec);
    } // END if
  } // END for
  return 0;
} // END main



void RK4(const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
		     void (*derivada)( const double *, const double, double *)){
  double *k0 = new double[n_ec];
  double *k1 = new double[n_ec];
  double *k2 = new double[n_ec];
  double *k3 = new double[n_ec];
  double *z  = new double[n_ec];

  (*derivada)(y, t, k0);

  for(int i=0; i<n_ec; i++)
    z[i] = y[i] + 0.5*k0[i]*h;

  (*derivada)(z, t+0.5*h, k1);

  for(int i=0; i<n_ec; i++)
    z[i] = y[i] + 0.5*k1[i]*h;

  (*derivada)(z, t+0.5*h, k2);

  for(int i=0; i<n_ec; i++)
    z[i] = y[i] + k2[i]*h;

  (*derivada)(z, t+h, k3);

  for(int i=0; i<n_ec; i++)
   y_imas1[i] = y[i] + h/6.0 * ( k0[i] + 2*k1[i] + 2*k2[i] + k3[i] );

  delete[] k0;
  delete[] k1;
  delete[] k2;
  delete[] k3;
  delete[] z;
}





void salidaSolucion(const double t, const double *y, const int N){
  cout << fixed << setprecision(3) << t;

  for( int i=0; i<N; i++ )
    cout << scientific << setprecision(9) << "\t" << y[i];

  cout << endl;
}




void spaceCraft(const double *y, const double t, double *dydt){
  const double m1 = 5.972e24; //masa de la tierra
  const double m2 = 7.348e22; //masa de la luna
	//const double m2 = 0.0; // masa de la luna, prueba ej 1
  const double m3 = 1000; //masa de la nave
  const double G  = 6.66e-11; // Constante de gravitacion universal

  // distancias
  const double r21_3 = pow( pow(y[2]-y[0],2) + pow(y[3]-y[1],2), 1.5 );
  const double r31_3 = pow( pow(y[4]-y[0],2) + pow(y[5]-y[1],2), 1.5 );
  const double r32_3 = pow( pow(y[4]-y[2],2) + pow(y[5]-y[3],2), 1.5 );



  dydt[0]  = y[6];
  dydt[1]  = y[7];
  dydt[2]  = y[8];
  dydt[3]  = y[9];
  dydt[4]  = y[10];
  dydt[5]  = y[11];
  dydt[6]  = -G*m2*( y[0]-y[2] ) / r21_3 - G*m3*( y[0]-y[4] ) / r31_3;
  dydt[7]  = -G*m2*( y[1]-y[3] ) / r21_3 - G*m3*( y[1]-y[5] ) / r31_3;
  dydt[8]  = -G*m1*( y[2]-y[0] ) / r21_3 - G*m3*( y[2]-y[4] ) / r32_3;
  dydt[9]  = -G*m1*( y[3]-y[1] ) / r21_3 - G*m3*( y[3]-y[5] ) / r32_3;
  dydt[10] = -G*m1*( y[4]-y[0] ) / r31_3 - G*m2*( y[4]-y[2] ) / r32_3;
  dydt[11] = -G*m1*( y[5]-y[1] ) / r31_3 - G*m2*( y[5]-y[3] ) / r32_3;
} // END spaceCraft
