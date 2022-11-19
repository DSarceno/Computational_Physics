//===================================
//
// Metodo de Euler Mejorado
//
//===================================

#include <iostream>
#include <cmath>


using namespace std;


double euler_mejorado( double y, double t, double h );
double derivada( double y, double t );

int main()
{
  // Datos iniciales
  const double y0 = 0.0;
  const double t0 = 0.0;
  const double h = 0.025;
  const int N = 2000; // numero de iteraciones
  
  double y = y0;
  double t = t0;
  double y_nueva = 0.0;

  cout << t << "\t" << y << endl;
  
  // ciclo de iteraciones
  for( int i=1; i<=N; i++ ){

    y_nueva = euler_mejorado( y, t, h );

    y = y_nueva;
    t = t + h;

    if ( i%4 == 0)
      cout << t << "\t" << y << endl;
  }
  
  return 0;
}


double euler_mejorado( double y, double t, double h )
{
  double y_tilde = y + h*derivada( y, t );
  double y_imas1 = y + 0.5*h * ( derivada( y, t ) + derivada( y_tilde, t+h ) ); 
  
  return y_imas1;
}


double derivada( double y, double t )
{
  return cos(2*t);
}
