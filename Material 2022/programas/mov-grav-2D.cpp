//============================================
//
// Metodo de Euler Mejorado para movimiento
// gravitacional en 2 dimensiones
//
//============================================

#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>


using namespace std;



void euler_mejorado( const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
		     void (*derivada)( const double *, const double, double * ) );

void energia( const double t, const double *y, ofstream &energia_salida );
void salidaSolucion( const double t, const double *y, const int N );
void caidaLibreFriccion( const double *y, const double t, double *dydt );
void oscilador( const double *y, const double t, double *dydt );
void movGrav1D( const double *y, const double t, double *dydt );
void movGrav2D( const double *y, const double t, double *dydt );




int main()
{
  // Datos iniciales
  const double t0 = 0.0;
  const double h = 60;
  const int N = 25920000*6/10/60; // numero de iteraciones
  const int out_cada = 60/4; // output cada out_cada iteraciones
  const int n_ec = 4; // numero de ecuaciones
  ofstream energia_salida;

  // Archivo que guarda la energia total
  energia_salida.open( "energia.dat", ios::out );


  // reservar espacio para y
  double *y       = new double[ n_ec ];
  double *y_nueva = new double[ n_ec ];

  // inicializar cada variable segun las condiciones iniciales
  y[0] = 3.844e8;
  y[1] = 0.0;
  y[2] = 0.0;
  y[3] = 1.022e3/2;

  // puntero a la funcion "derivada"
  void (*derivada)( const double *, const double, double * );
  derivada = movGrav2D;
  

  // inicializar y_nueva
  for( int i=0; i<n_ec; i++ ) y_nueva[i] = 0.0;
  
  double t = t0;
  

  salidaSolucion( t, y, n_ec );
  energia( t, y, energia_salida );
  
  // ciclo de iteraciones
  for( int i=1; i<=N; i++ ){
    euler_mejorado( y, n_ec, t, h, y_nueva, derivada );

    y = y_nueva;
    t = t + h;

    if ( i%out_cada == 0){
      salidaSolucion( t, y, n_ec );
      energia( t, y, energia_salida );
    }
    
  }
  
  return 0;
}



void energia( const double t, const double *y, ofstream &energia_salida )
{
  const double m = 7.34e22; //masa de la Luna
  const double M = 5.98e24; // masa de la Tierra
  const double G = 6.66e-11; // Constante de gravitacion universal
  double Ecinetica, Epotencial, Energia;
  
  Ecinetica = 0.5*m*(y[2]*y[2] + y[3]*y[3]);
  Epotencial =-G*M*m/sqrt( y[0]*y[0] + y[1]*y[1] );
  Energia = Ecinetica + Epotencial;

  energia_salida << fixed << setprecision(3) << t;
  energia_salida << scientific << setprecision(9) << "\t" << Energia << endl;
}



void salidaSolucion( const double t, const double *y, const int N )
{
  cout << fixed << setprecision(3) << t;

  for( int i=0; i<N; i++ )
    cout << scientific << setprecision(9) << "\t" << y[i];

  cout << endl;  
}




void euler_mejorado( const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
		     void (*derivada)( const double *, const double, double * ) )
{
  
  double *dydt    = new double[ n_ec ];
  double *dydt_2  = new double[ n_ec ];
  double *y_tilde = new double[ n_ec ];

  // inicializar variables
  for( int i=0; i<n_ec; i++ ) {
    dydt[i]    = 0.0;
    dydt_2[i]  = 0.0;
    y_tilde[i] = 0.0;
  }
  

  (*derivada)( y, t, dydt );

  for( int i=0; i<n_ec; i++ )
    y_tilde[i] = y[i] + h*dydt[i];

  (*derivada)( y_tilde, t+h, dydt_2 );

  for( int i=0; i<n_ec; i++ )
    y_imas1[i] = y[i] + 0.5*h * ( dydt[i] + dydt_2[i] );

  

  delete[] dydt;
  delete[] dydt_2;
  delete[] y_tilde;
}


void caidaLibreFriccion( const double *y, const double t, double *dydt )
{
  const double g = 9.8; // aceleracion gravedad
  const double m = 0.5; // masa
  const double b = 1.0; // constante de friccion
  
  dydt[0] = y[1];
  dydt[1] = -g - b/m*y[1];
}




void oscilador( const double *y, const double t, double *dydt )
{
  const double m = 0.1; // masa
  const double b = 0.1; // constante de friccion
  const double k = 0.01;// constante del resorte

  dydt[0] = y[1];
  dydt[1] = (sin(M_PI*t/5.0) - b*y[1] - k*y[0] ) / m;
}



void movGrav1D( const double *y, const double t, double *dydt )
{
  const double M = 5.98e24; // masa de la Tierra
  const double G = 6.66e-11; // Constante de gravitacion universal


  dydt[0] = y[1];
  dydt[1] = -G*M/(y[0]*y[0]);
}



void movGrav2D( const double *y, const double t, double *dydt )
{
  const double M = 5.98e24; // masa de la Tierra
  const double G = 6.66e-11; // Constante de gravitacion universal
  const double r3 = pow( y[0]*y[0] + y[1]*y[1], 1.5 );

  dydt[0] = y[2];
  dydt[1] = y[3];
  dydt[2] = -G*M*y[0] / r3;
  dydt[3] = -G*M*y[1] / r3;    
}
