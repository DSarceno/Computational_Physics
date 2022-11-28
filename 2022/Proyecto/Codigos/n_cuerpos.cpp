// jue 24 nov 2022 10:41:00 CST
// n_cuerpos.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o n_cuerpos.o n_cuerpos.cpp
// g++ -o n_cuerpos.x n_cuerpos.o


// Librerias
#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>
#include <cstdlib>
#include <random>


using namespace std;


std::default_random_engine generator(17); // seed
std::uniform_real_distribution<long double> random_interval(-1.0,1.0);








// constantes globales
#define n_cuerpos 100;
#define n_ec 4*n_cuerpos;
#define G 6.67e-11;




// Variables globales
double *xp, *yp; // posicion en x, y
double *vx, *vy; // velocidad en x, y
double ax[n_cuerpos], ay[n_cuerpos]; // aceleracion en x, y
double masa[n_cuerpos]; // masa de cada particula
double E, P, L;






// Inicializar masas
void init_masa(){
	for (int i = 0; i < n_cuerpos; i++){
		masa[i] = 10e18;
	} // END FOR
} // END masa

// Inicializar posiciones
void init_posicion(){
  for (int i = 0; i < n_cuerpos; i++){
		xp[i] = random_interval(generator)*1.5e11;
		yp[i] = random_interval(generator)*1.5e11;
	} // END FOR
} // END init_posicion

  // Inicializar velocidades
void init_velocidad(){
	for (int i = 0; i < n_cuerpos; i++){
		double ri = sqrt(pow(xp[i],2) + pow(xy[i],2));
		double vi = sqrt(G*M_PI*n_cuerpos*m[i]*ri)/(2*1.5e11);

		vx[i] = vi*(-1.0*(yp[i]/ri) + random_interval(generator));
		vx[i] = vi*((xp[i]/ri) + random_interval(generator));
	} // END FOR
} // END init_velocidad


void calc_aceleracion(){
	for (int i = 0; i < n_cuerpos; i++){
		ax[i] = 0;
		ay[j] = 0;
		for (int j = 0; j< n_cuerpos; j++){
			double deltaX = xp[i] - xp[j];
			double deltaY = yp[i] - yp[j];
			double common_term = G*m[j]*pow(pow(deltaX, 2) + pow(deltaY, 2), -3/2);
			ax[j] -= common_term*deltaX;
			ay[i] -= common_term*deltaY;
		} // END FOR
	} // END FOR
} // END calc_aceleracion




// Derivadas del sistemas de ecuaciones
void nCuerposGrav(double y[n_ec], const double t, double dydt[n_ec]){
  xp   = y;
  yp   = y +   n_cuerpos;
  vx   = y + 2*n_cuerpos;
  vy   = y + 3*n_cuerpos;

  // Calcular aceleraciones
  calc_aceleracion();

  for( int i=0; i<n_cuerpos; i++ ){
    dydt[i              ] = vx[i];
    dydt[i +   n_cuerpos] = vy[i];
    dydt[i + 2*n_cuerpos] = ax[i];
    dydt[i + 3*n_cuerpos] = ay[i];
  } // END FOR
} // END nCuerposGrav


void energia_momentos(){
	
} // END energia_momentos





void salidaSolucion(const double t, ofstream &of ){

} // END salidaSolucion


void salidaVelocidad(const double t, ofstream &of){

} // END salidaVelocidad





void salidaEnergia(const double tiempo, ofstream &of){

} // END salidaEnergia




void salidaMomentumLineal(const double tiempo, ofstream &of){

} // END salidaMomentumLineal




void salidaMomentumAngular(const double tiempo, ofstream &of){

} // END salidaMomentumAngular




void salidaMasa(double t, ofstream &of){

} // END salidaMasa



void verificar_colisiones( double t )
{
  double dist_lim = 1.0e7;

  for( int i=0; i<n_cuerpos; i++ ){
    if ( masa[i] != 0.0 ){
      for( int j=0; j<i; j++ ){
	if ( masa[j] != 0.0 ){
	  double dx = xp[i]-xp[j];
	  double dy = yp[i]-yp[j];
	  double distancia = sqrt( dx*dx + dy*dy );
	  if ( distancia < dist_lim ){
	    vx[i] = (masa[i]*vx[i] + masa[j]*vx[j] ) / (masa[i]+masa[j]);
	    vy[i] = (masa[i]*vy[i] + masa[j]*vy[j] ) / (masa[i]+masa[j]);
	    masa[i] = masa[i] + masa[j];

	    // particula j sigue la misma trayectoria que particula i pero sin masa
	    vx[j] = 0.0;
	    vy[j] = 0.0;
	    masa[j] = 0.0;
	    cout << "Colision "<< i <<" "<< j << " en t = " << t << endl;
	  }
	}
      }
    }
  }
}





int main()
{
  // Parametros
	// de 5 días en 5 días
  const int Niter = 73*5000; // numero de iteraciones
  const double h_step = 432000; // tamaño de paso
  const int out_cada = 1000; // output cada out_cada iteraciones


  // Otras variables
  const int n_ec = n_cuerpos * 4; // numero de ecuaciones
  double tiempo = 0.0;

  // Archivos de salida
  ofstream of_posicion( "posicion.dat", ios::out );
  ofstream of_velocidad( "velocidad.dat", ios::out );
  ofstream of_energia( "energia.dat", ios::out );
  ofstream of_momentumLineal( "momLineal.dat", ios::out );
  ofstream of_momentumAngular( "momAngular.dat", ios::out );
  ofstream of_masa( "masa.dat", ios::out );


  // reservar espacio para y
  double y[n_ec];
  double y_nueva[n_ec];

  // reservar espacio para posicion y velocidad
  xp   = y;
  yp   = y +   n_cuerpos;
  vx   = y + 2*n_cuerpos;
  vy   = y + 3*n_cuerpos;


  // puntero a la funcion "derivada"
  void (*derivada)( double *, const double, double * );
  derivada = nCuerposGrav;


  // inicializar y_nueva
  for( int i=0; i<n_ec; i++ ) y_nueva[i] = 0.0;



  // Inicializar masa
  init_masa();

  // Inicializar posicion
  init_posicion();

  // Inicializar velocidad
  init_velocidad();



  // ciclo de iteraciones
  for( int k=0; k<=Niter; k++ ){
    // Nombres faciles para las variables
    xp   = y;
    yp   = y +   n_cuerpos;
    vx   = y + 2*n_cuerpos;
    vy   = y + 3*n_cuerpos;

    // Verificar colisiones
    verificar_colisiones( tiempo );

    // salida
    if ( k%out_cada == 0){
      salidaSolucion( tiempo, of_posicion );
      salidaVelocidad( tiempo, of_velocidad );
      salidaEnergia( tiempo, of_energia );
      salidaMomentumLineal( tiempo, of_momentumLineal );
      salidaMomentumAngular( tiempo, of_momentumAngular );
      salidaMasa( tiempo, of_masa );
    }



    //euler_mejorado( y, n_ec, tiempo, h_step, y_nueva, derivada );
    RK4( y, n_ec, tiempo, h_step, y_nueva, derivada );

    // Intercambiar valores
    for( int i=0; i<n_ec; i++ ) y[i] = y_nueva[i];



    // Incrementar el tiempo
    tiempo += h_step;
  }

  return 0;
}










void RK4( double *y,
	  const int n_ec,
	  const double t,
	  const double h,
	  double *y_imas1,
	  void (*derivada)( double *, const double, double * ) )
{
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
   y_imas1[i] = y[i] + h/6.0 * ( k0[i] + 2*k1[i] + 2*k2[i] + k3[i] );

  delete[] k0;
  delete[] k1;
  delete[] k2;
  delete[] k3;
  delete[] z;
}
