//===================================================
//
// Ecuacion de calor con diferencias finitas
//
//===================================================


#include <iostream>
#include <fstream>
#include <cmath>
#include <omp.h>

using namespace std;

double p1( double x, double t );
double p2( double x, double t );
double f_cond_ini( double x, double y );
double g_cond_ini( double x, double y );
double q2( double y, double t );
double q1( double y, double t );
void condiciones_frontera( double **UU, int Nx, int Ny, double *x, double *y, double tiempo);
void condiciones_iniciales( double **u, int Nx, int Ny, double *x, double *y, double dt );
void output( ostream &of, double **u, double *x, double *y, double t, int Nx, int Ny );



int main( int argc, char *argv[] )
{
  if ( argc==1 ){
    cout << "Uso: ./a.out <# de iteraciones>" << endl;
    cout << endl;
    exit(1);
  }
    
  int Niter = atoi( argv[1] ); // numero de iteraciones en el tiempo

  
  int Nx = 100; //numero de puntos en x
  int Ny = 100; //numero de puntos en y
  int out_cada = 500; //output cada no. de iteraciones
  double Lx = 1.0; //longitud del dominio en x
  double Ly = 1.0; //longitud del dominio en y
  double dx = Lx/Nx;
  double alfa = 0.2;
  double c_calor = 1.0; // constante en la ec. de calor
  double dt = alfa*dx*dx/(c_calor*c_calor);
    double tiempo = 0.0; // lleva la cuenta del tiempo
  ofstream of;
  of.open( "solucion.dat", ios::out );

  // Informacion sobre los datos
  of << "# columna 1: tiempo" << endl;
  of << "# columna 2: coordenada x" << endl;
  of << "# columna 3: coordenada y" << endl;
  of << "# columna 4: u(x,y,t)" << endl;



  // variables para u
  double **u_nueva = new double*[Nx+1]; // u_{ij,k+1}
  double **u       = new double*[Nx+1]; // u_{ij,k}
  double *x        = new double[Nx+1]; // coordenada x
  double *y        = new double[Ny+1]; // coordenada y


  
  for( int i=0; i<Nx+1; i++ ){
    u_nueva[i] = new double[Ny+1];
    u[i]       = new double[Ny+1];  
  }


  
  // coordenada x
  for( int i=0; i<Nx+1; i++ )
    x[i] = i*dx;

    // coordenada y
  for( int i=0; i<Ny+1; i++ )
    y[i] = i*dx;

  cout << "dx = "<< dx << endl;
  cout << "dt = "<< dt << endl;

  
  // condiciones iniciales
  condiciones_iniciales( u, Nx, Ny, x, y, dt );


  // condicion de frontera
  condiciones_frontera( u, Nx, Ny, x, y, tiempo);

  
  tiempo += dt;
  
  // ciclo principal
  for( int k=0; k<=Niter; k++ ){

#pragma omp parallel for collapse(2)
    for( int i=1; i<Nx; i++ ){
      for( int j=1; j<Ny; j++ ){
	u_nueva[i][j] = u[i][j] + alfa*
	  (u[i-1][j] + u[i+1][j] + u[i][j-1] + u[i][j+1] - 4.*u[i][j] );
      }
    }
    // condicion de frontera
    condiciones_frontera( u_nueva, Nx, Ny, x, y, tiempo + dt);
    

    // cambiar instantes de tiempo
#pragma omp parallel for collapse(2)
    for(int i=0; i<Nx+1; i++ ){
      for( int j=0; j<Ny+1; j++ ){
	u[i][j]       = u_nueva[i][j];
      }
    }

    tiempo += dt;

    // output
    if ( k % out_cada == 0 ){
      output( of, u, x, y, tiempo, Nx, Ny );
      cout << "it = " << k << " / " << Niter << endl;
    }
    
  }

  

  return 0;
}



void output( ostream &of, double **u, double *x, double *y, double t, int Nx, int Ny )
{
  for( int i=0; i<Nx+1; i++ ){
    for( int j=0; j<Ny+1; j++ )
      of << t << "\t" << x[i] << "\t" << y[j] << "\t" << u[i][j] << endl;

    of << endl;
  }
  of << endl;
}



void condiciones_iniciales( double **u, int Nx, int Ny, double *x, double *y, double dt )
{
  for( int i=0; i<Nx+1; i++ ){
    for( int j=0; j<Ny+1; j++ ){
      u[i][j] = f_cond_ini( x[i], y[j] );
    }
  }
}



void condiciones_frontera( double **UU, int Nx, int Ny, double *x, double *y, double tiempo)
{
  // borde inferior y superior
#pragma omp parallel for
  for( int i=0; i<Nx+1; i++ ){
    UU[i][0]  = p1( x[i], tiempo );
    UU[i][Ny] = p2( x[i], tiempo );
  }

    // borde izquierdo y derecho
#pragma omp parallel for
  for( int j=0; j<Ny+1; j++ ){
    UU[0][j]  = q1( y[j], tiempo );
    UU[Nx][j] = q2( y[j], tiempo );
  }
}



double p1( double x, double t )
{
  return 10.0;
}

double p2( double x, double t )
{
  return 0.0;
}


double q1( double y, double t )
{
  double w = 4000;
  double omega = 10.0;
  double s = 20.0; // atenuacion en el tiempo
  double Ly = 1.0; // longitud en y

  return 100*( exp(-pow(w*(y-0.25*Ly),2)) + exp(-pow(w*(y-0.75*Ly),2))   ) * sin( omega*t );

  //return 0.0;

}

double q2( double y, double t )
{
  return 0.0;
}


double f_cond_ini( double x, double y )
{
  double Lx = 1.0; // longitud en x
  double Ly = 1.0; // longitud en y
  double w  = 800; // Controla el ancho del pulso
  
  //return sin(4*2.*M_PI*x);
  //return exp(-100*pow(x-L/2,2));
  //return -exp( -w*( pow(x-0.25*Lx,2) + pow(y-0.5*Ly,2)) );
  return 0.0;
}

double g_cond_ini( double x, double y )
{
  double L = 1.0; // longitud de la cuerda
  //return sin(4*2.*M_PI*x);
  //return exp(-100*pow(x-L/2,2));
  return 0.0;
}



