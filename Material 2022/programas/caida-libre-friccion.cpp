//============================================
//
// Metodo de Euler Mejorado para la ecuacion
// de caida libre con friccion del aire
//
//============================================

#include <iostream>
#include <cmath>


using namespace std;



void euler_mejorado( const double y, const double t, const double h, double &y_imas1 );
void derivada( const double y, const double t, double &dydt );



int main()
{
  // Datos iniciales
  const double y0 = 0.0;
  const double t0 = 0.0;
  const double h = 0.1;
  const int N = 100; // numero de iteraciones
  const int out_cada = 1; // output cada out_cada iteraciones
  
  double y = y0;
  double t = t0;
  double y_nueva = 0.0;

  cout << t << "\t" << y << endl;
  
  // ciclo de iteraciones
  for( int i=1; i<=N; i++ ){
    euler_mejorado( y, t, h, y_nueva );

    y = y_nueva;
    t = t + h;

    if ( i%out_cada == 0)
      cout << t << "\t" << y << endl;
  }
  
  return 0;
}


void euler_mejorado( const double y, const double t, const double h, double &y_imas1 )
{
  double dydt = 0.0;
  double dydt_2 = 0.0;
  double y_tilde = 0.0;

  derivada( y, t, dydt );
  
  y_tilde = y + h*dydt;

  derivada( y_tilde, t+h, dydt_2 );

  y_imas1 = y + 0.5*h * ( dydt + dydt_2 );

}


void derivada( const double y, const double t, double &dydt )
{
  const double g = 9.8; // aceleracion gravedad
  const double m = 0.5; // masa
  const double b = 1.0; // constante de friccion
  
  dydt = -g - b/m*y;
}
