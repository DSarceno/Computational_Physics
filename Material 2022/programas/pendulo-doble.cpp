//============================================
//
// Pendulo doble compuesto
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

void RK4( const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
	             void (*derivada)( const double *, const double, double * ) );

void energia( const double t, const double *y, ofstream &energia_salida );
void energia_3cuerpos( const double t, const double *y, ofstream &energia_salida );
void salidaSolucion( const double t, const double *y, const int N );
void caidaLibreFriccion( const double *y, const double t, double *dydt );
void oscilador( const double *y, const double t, double *dydt );
void movGrav1D( const double *y, const double t, double *dydt );
void movGrav2D( const double *y, const double t, double *dydt );
void movGrav2D_3cuerpos(  const double *y, const double t, double *dydt );
void pendulo_doble( const double *y, const double t, double *dydt );



int main()
{
  // Datos iniciales
  const double t0 = 0.0;
  const double h = 0.005;
  const int N = 12000*2; // numero de iteraciones
  const int out_cada = 2*2; // output cada out_cada iteraciones
  const int n_ec = 12; // numero de ecuaciones
  ofstream energia_salida;

  // Archivo que guarda la energia total
  energia_salida.open( "energia.dat", ios::out );


  // reservar espacio para y
  double *y       = new double[ n_ec ];
  double *y_nueva = new double[ n_ec ];

  // inicializar cada variable segun las condiciones iniciales
  y[0]  = 0.5*M_PI;
  y[1]  = 0.5*M_PI;
  y[2]  = 0.0;
  y[3]  = 0.0;
  
    

  // puntero a la funcion "derivada"
  void (*derivada)( const double *, const double, double * );
  derivada = pendulo_doble;
  

  // inicializar y_nueva
  for( int i=0; i<n_ec; i++ ) y_nueva[i] = 0.0;
  
  double t = t0;
  

  salidaSolucion( t, y, n_ec );
  energia_3cuerpos( t, y, energia_salida );
  
  // ciclo de iteraciones
  for( int i=1; i<=N; i++ ){
    //euler_mejorado( y, n_ec, t, h, y_nueva, derivada );
    RK4( y, n_ec, t, h, y_nueva, derivada );

    y = y_nueva;
    t = t + h;

    if ( i%out_cada == 0){
      salidaSolucion( t, y, n_ec );
      energia_3cuerpos( t, y, energia_salida );
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


void energia_3cuerpos( const double t, const double *y, ofstream &energia_salida )
{
  const double m1 = 1.989e30; //masa del sol
  const double m2 = 5.972e24; //masa de la tierra
  const double m3 = 7.348e22; //masa de la luna
  const double G = 6.66e-11; // Constante de gravitacion universal

  // distancias
  const double r21 = pow( pow(y[2]-y[0],2) + pow(y[3]-y[1],2), 0.5 );
  const double r31 = pow( pow(y[4]-y[0],2) + pow(y[5]-y[1],2), 0.5 );
  const double r32 = pow( pow(y[4]-y[2],2) + pow(y[5]-y[3],2), 0.5 );
  
  double Ecinetica, Epotencial, Energia;
  
  Ecinetica = 0.5*m1*(y[6]*y[6]   + y[7]*y[7]) +
              0.5*m2*(y[8]*y[8]   + y[9]*y[9]) +
              0.5*m3*(y[10]*y[10] + y[11]*y[11]);
  
  Epotencial =-G*m1*m2/r21 - G*m1*m3/r31 - G*m2*m3/r32;
  
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






void RK4( const double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
		     void (*derivada)( const double *, const double, double * ) )
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



void movGrav2D_3cuerpos(  const double *y, const double t, double *dydt )
{
  const double m1 = 1.989e30; //masa del sol
  const double m2 = 5.972e24; //masa de la tierra
  const double m3 = 7.348e22; //masa de la luna
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

}




void pendulo_doble( const double *y, const double t, double *dydt )
{
  const double m = 0.5; 
  const double l = 0.3; 
  const double g = 9.8;
    

  dydt[0] = 6.0/(m*l*l) * (2.0*y[2] - 3.0*y[3]*cos(y[0] - y[1]))/(16.0 - 9.0*pow(cos(y[0] - y[1]),2));
  dydt[1] = 6.0/(m*l*l) * (8.0*y[3] - 3.0*y[2]*cos(y[0] - y[1]))/(16.0 - 9.0*pow(cos(y[0] - y[1]),2));
  dydt[2] =-0.5*m*l*l   * ( dydt[0]*dydt[1]*sin(y[0] - y[1]) + 3.0*g/l*sin(y[0]));
  dydt[3] =-0.5*m*l*l   * (-dydt[0]*dydt[1]*sin(y[0] - y[1]) +  g/l*sin(y[1]));

}
