// jue 24 nov 2022 11:28:23 CST
// pruebas.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o pruebas.o pruebas.cpp
// g++ -o pruebas.x pruebas.o


// Librerias
#include<iostream>
#include<cstdlib>


using namespace std;


void init_posicion(double xp, double yp, int n_cuerpos);
void mostrar(double b[], int size);

// Variables globales
double *xp, *yp; // posicion en x, y
double *vx, *vy; // velocidad en x, y
double *ax, *ay; // aceleracion en x, y
double *masa; // masa de cada particula
int n_cuerpos; // numero de cuerpos
const int n_seed = 17;





//int main(int argc, char *argv[]) {
int main(){
  //int n_seed = atoi(argv[1]);
  //double random = rand();
  n_cuerpos = 10.0;
  /*
  // srand() has not been called), so seed = 1
  cout << "Seed = 1, Random number = " << random << endl;

  // set seed to 5
  srand(n_seed);

  // generate random number
  random = rand()%(1000 - (-1000) + 1) - 1000;
  random /= 1000;
  cout << "Seed = 5, Random number = " << random << endl;
  */

  init_posicion(&xp, &yp, n_cuerpos);
  mostrar(xp, n_cuerpos);
  mostrar(yp, n_cuerpos);
  return 0;
}




// Inicializar posiciones
void init_posicion(double xp, double yp, int n_cuerpos){
  double space = 0.0;
  for (int i = 0; i <= n_cuerpos; i++){
    space = rand()%(1000 - (-1000) + 1) - 1000;
    xp[i] = space/1000;
  } // END FOR
  for (int j = 0; j <= n_cuerpos; j++){
    space = rand()%(1000 - (-1000) + 1) - 1000;
    yp[j] = space/1000;
  }
} // END init_posicion



void mostrar(double b[], int size){
  for (int i = 0; i <= size; i++)
    cout << b[i] << ' ';

  cout << endl;
}
