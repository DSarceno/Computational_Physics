//===============================================
//
// Proyecto problema de n cuerpos gravitacional
//
//===============================================

#include <iostream>
#include <cmath>
#include <iomanip>
#include <fstream>


using namespace std;



void euler_mejorado( double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
		     void (*derivada)( double *, const double, double * ) );

void RK4( double *y,
	  const int n_ec,
	  const double t,
	  const double h,
	  double *y_imas1,
	  void (*derivada)( double *, const double, double * ) );








// Variables globales
double *xp, *yp; // posicion en x, y
double *vx, *vy; // velocidad en x, y
double *ax, *ay; // aceleracion en x, y
double *masa; // masa de cada particula
int n_cuerpos; // numero de cuerpos





// Inicializar masas
void init_masa()
{

}

// Inicializar posiciones
void init_posicion()
{

}

  // Inicializar velocidades
void init_velocidad()
{

}


void calc_aceleracion()
{

}




// Derivadas del sistemas de ecuaciones
void nCuerposGrav( double *y, const double t, double *dydt )
{
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
  }
}





void salidaSolucion( const double t, ofstream &of  )
{

}


void salidaVelocidad( const double t, ofstream &of  )
{
  
}





void salidaEnergia( const double tiempo, ofstream &of )
{

}




void salidaMomentumLineal( const double tiempo, ofstream &of )
{

}




void salidaMomentumAngular( const double tiempo, ofstream &of )
{

}




void salidaMasa( double t, ofstream &of )
{

}



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
  const int Niter = ; // numero de iteraciones
  const double h_step = ; // tamaño de paso
  const int out_cada = ; // output cada out_cada iteraciones
  n_cuerpos = 100; // numero de cuerpos


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
  double *y       = new double[ n_ec ];
  double *y_nueva = new double[ n_ec ];

  // reservar espacio para posicion, velocidad, aceleracion y masa
  xp   = y;
  yp   = y +   n_cuerpos;
  vx   = y + 2*n_cuerpos;
  vy   = y + 3*n_cuerpos;
  ax   = new double[ n_cuerpos ];
  ay   = new double[ n_cuerpos ];
  masa = new double[ n_cuerpos ];
  
  
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













void euler_mejorado( double *y,
		     const int n_ec,
		     const double t,
		     const double h,
		     double *y_imas1,
		     void (*derivada)( double *, const double, double * ) )
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





