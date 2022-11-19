//===================================
//
// Metodo de Euler
//
//===================================

#include <iostream>

using namespace std;


double euler( double y, double t, double h );
double derivada( double y, double t );

int main()
{
  // Datos iniciales
  const double y0 = 3.1;
  const double t0 = 1.5;
  const double h = 0.1;
  const int N = 50; // numero de iteraciones
  
  double y = y0;
  double t = t0;
  double y_nueva = 0.0;

  cout << t << "\t" << y << endl;
  
  // ciclo de iteraciones
  for( int i=0; i<=N; i++ ){

    y_nueva = euler( y, t, h );

    y = y_nueva;
    t = t + h;
    
    cout << t << "\t" << y << endl;
  }
  
  return 0;
}


double euler( double y, double t, double h )
{
  return y + h*derivada( y, t );
}


double derivada( double y, double t )
{
  return y/10;
}
