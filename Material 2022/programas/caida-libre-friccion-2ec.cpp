//============================================
//
// Metodo de Euler Mejorado para la ecuacion
// de caida libre con friccion del aire
//
// El programa está escrito para utilizar sistemas
// de ecuaciones diferenciales
//
//============================================

#include <iostream>
#include <cmath>


using namespace std;


void euler_mejorado( const double *y, const int n_ec, const double t, const double h, double *y_imas1 );
void derivada( const double *y, const double t, double *dydt );

int main()
{
  // Datos iniciales
  const double y0 = 0.0;
  const double y1 = 0.0;
  const double t0 = 0.0;
  const double h = 0.1;
  const int N = 1000; // numero de iteraciones
  const int out_cada = 1; // output cada out_cada iteraciones
  const int n_ec = 2; // numero de ecuaciones


  // reservar espacio para y
  double *y       = new double[ n_ec ];
  double *y_nueva = new double[ n_ec ];

  // inicializar cada variable segun las condiciones iniciales
  y[0] = y0;
  y[1] = y1;

  // inicializar y_nueva
  for( int i=0; i<n_ec; i++ ) y_nueva[i] = 0.0;
  
  double t = t0;
  
  cout << t << "\t" << y[0] << "\t" << y[1] << endl;
  
  // ciclo de iteraciones
  for( int i=1; i<=N; i++ ){
    euler_mejorado( y, n_ec, t, h, y_nueva );

    y = y_nueva;
    t = t + h;

    if ( i%out_cada == 0)
      cout << t << "\t" << y[0] << "\t" << y[1] << endl;
  }
  
  return 0;
}


void euler_mejorado( const double *y, const int n_ec, const double t, const double h, double *y_imas1 )
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
  

  derivada( y, t, dydt );

  for( int i=0; i<n_ec; i++ )
    y_tilde[i] = y[i] + h*dydt[i];

  derivada( y_tilde, t+h, dydt_2 );

  for( int i=0; i<n_ec; i++ )
    y_imas1[i] = y[i] + 0.5*h * ( dydt[i] + dydt_2[i] );


  delete[] dydt, dydt_2, y_tilde;
}


//void derivada( const double *y, const double t, double *dydt )
//{
//  const double g = 9.8; // aceleracion gravedad
//  const double m = 0.5; // masa
//  const double b = 1.0; // constante de friccion
//  
//  dydt[0] = y[1];
//  dydt[1] = -g - b/m*y[1];
//}




void derivada( const double *y, const double t, double *dydt )
{
  const double m = 0.1; // masa
  const double b = 0.1; // constante de friccion
  const double k = 0.01;// constante del resorte

  dydt[0] = y[1];
  dydt[1] = (sin(M_PI*t/5.0) - b*y[1] - k*y[0] ) / m;
}
