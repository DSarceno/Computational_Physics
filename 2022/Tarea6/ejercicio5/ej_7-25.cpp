// vie 18 nov 2022 16:26:24 CST
// ej_7-25.cpp
// Diego Sarceno (dsarceno68@gmail.com)

// Resumen

// Codificado del texto: UTF8
// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0
// Instruciones de Ejecución: no requiere nada mas
// g++ -Wall -c -o ej_7-25.o ej_7-25.cpp
// g++ -o ej_7-25.x ej_7-25.o


// Librerias
#include <cmath>
#include <iostream>
#include <fstream>
#include <complex>
#include <iomanip>


using namespace std;



void output( complex<double> *u, double *x, double tiempo, int N, ostream &of );
void fourier( complex<double> *ftrans, complex<double> *f, int n );
void fourierInversa( complex<double> *f, complex<double> *ftrans, int n );


ofstream solucion;
complex<double> I(0.0, 1.0);

int main()
{
  int N = 300;
  int Niter = 30;
  int outCada = 1;
  double tiempo = 0.0;
  double L = 30.0;
  double k0 = 2*M_PI/(N+1);
  double hbar = sqrt(7.6199682);
  double masa = 8.0;
  double dx    = 2*L/N;
  double dt    = 2;
  double delta_x = 1.0; // Ancho del paquete
  double k0momentum = sqrt(2*masa*100)/hbar;  // T=p^2/(2m), p=hbar*k
  double a_potencial = 1.963; //
  solucion.open( "solucion.dat", ios::out );

  // Cantidades complejas
  complex<double> *psi, *trans, *phi, *expV, *expT;
  psi    = new complex<double>[ N+1 ];
  phi    = new complex<double>[ N+1 ];
  trans  = new complex<double>[ N+1 ];
  expV   = new complex<double>[ N+1 ];
  expT   = new complex<double>[ N+1 ];

  // Cantidades reales
  double *x, *k, *V;
  k = new double[ N+1 ];
  x = new double[ N+1 ];
  V = new double[ N+1 ];



  // Inicializar coordenada x
  for(int i=0; i<N+1; i++)
    x[i] = -L + i*dx;

  // Inicializar k
  for(int i=0; i<(N+1)/2; i++)
    k[i] = i*k0;

  for(int i=(N+1)/2; i<N+1; i++)
    k[i] = -k[N+1-i];


  // Inicializar Potencial
  for(int i=0; i<N+1; i++){
    if ( 0<=x[i] && x[i]<=a_potencial )
      V[i] = -200.0;
    else
      V[i] = 0.0;

  }

  // Inicializar expomenciales de T y V
  for(int i=0; i<N+1; i++){
    expV[i] = exp( -I*V[i]*dt/(2*hbar) );
    expT[i] = exp( -I*hbar*k[i]*k[i]*dt/(2*masa) );
  }



  /* condiciones de frontera */
  //psi[0] = 0;
  //psi[N] = 0;


  // condiciones iniciales
  for(int i=0; i<N+1; i++)
    psi[i] = exp(I*k0momentum*x[i] - x[i]*x[i]/pow(2*delta_x,2) )/pow(2*M_PI*pow(delta_x,2),0.25);


  // ciclo principal
  for(int j=0; j<=Niter; j++){

    if ( j%outCada==0 ){
      cout << "it = " << j << " / " << Niter << endl;;
      output( psi, x, tiempo, N, solucion );
    }


    // Aplicacion de los operadores
    for(int i=0; i<N+1; i++)
      phi[i] = expV[i] * psi[i];

    fourier( trans, phi, N+1 );

    for(int i=0; i<N+1; i++)
      phi[i] = expT[i] * trans[i];

    fourierInversa( psi, phi, N+1 );

    for(int i=0; i<N+1; i++)
      psi[i] = expV[i] * psi[i];


    // condiciones de frontera
    psi[0] = 0.0;
    psi[N] = 0.0;


    tiempo += dt;

  }

  return 0;
}



/***********************************************************************/



//double f( double x )
//{
  //return sqrt(2.0)*sin(5*x*M_PI);
  //return cexp(-50*pow(x-0.5,2) -I*100*x);
//}


void output( complex<double> *psi, double *x, double tiempo, int N, ostream &of )
{
  for(int i=0; i<N+1; i++)
    of << tiempo << "\t" << x[i] << "\t"  << real(psi[i]) << "\t" << imag(psi[i]) << endl;

  of << endl << endl;
}



void fourier( complex<double> *ftrans, complex<double> *f, int n )
{
  for( int i=0; i<n+1; i++ ){
    ftrans[i] = 0.0;
    for( int j=0; j<n+1; j++ )
      ftrans[i] += f[j] * exp(-2*M_PI*I * (double)j * (double)i / (double)n);

    ftrans[i] /= sqrt(n);
  }
}


void fourierInversa( complex<double> *f, complex<double> *ftrans, int n )
{
  for( int i=0; i<n+1; i++ ){
    f[i] = 0.0;
    for( int j=0; j<n+1; j++ )
      f[i] += ftrans[j] * exp(2*M_PI*I*(double)j*(double)i/(double)n);

    f[i] /= sqrt(n);
  }
}
