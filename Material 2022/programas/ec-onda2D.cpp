//===================================================
//
// Ecuacion de onda en 2D con diferencias finitas
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
void condiciones_iniciales( double **u_vieja, double **u, int Nx, int Ny, double *x, double *y, double dt );
void output( ostream &of, double **u, double *x, double *y, double t, int Nx, int Ny );

int main()
{
  int Nx = 400; //numero de puntos en x
  int Ny = 400; //numero de puntos en y
  int out_cada = 20; //output cada no. de iteraciones
  double Lx = 1.0; //longitud del dominio en x
  double Ly = 1.0; //longitud del dominio en y
  double dx = Lx/Nx;
  // double alfa = 0.5;
  // double vel = 1.0; // velocidad de la onda
  // double dt = alfa*dx/vel;
  double alfa;
  double dt;
  int Niter = 2000; // numero de iteraciones en el tiempo
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
  double **u_vieja = new double*[Nx+1]; // u_{ij,k-1}
  double **vel     = new double*[Nx+1];
  double *x        = new double[Nx+1]; // coordenada x
  double *y        = new double[Ny+1]; // coordenada y


  
  for( int i=0; i<Nx+1; i++ ){
    u_nueva[i] = new double[Ny+1];
    u[i]       = new double[Ny+1];
    u_vieja[i] = new double[Ny+1];
    vel[i]     = new double[Ny+1];
  }

  /*
  // asignar las velocidades
  // lado izquierdo
  for( int i=0; i<(Nx+1)/2; i++ ){
    for( int j=0; j<Ny+1; j++ ){
      vel[i][j] = 1.0;
      //cout << "v[" << i << "][" << j << "] = " << vel[i][j] << endl;
    }
  }
  
  // lado derecho
  for( int i=(Nx+1)/2; i<Nx+1; i++ ){
    for( int j=0; j<Ny+1; j++ ){
      vel[i][j] = 0.4;
    }
  }
  */

  
  // asignar las velocidades
  // lado izquierdo
  for( int i=0; i<(Nx+1)/2; i++ ){
    for( int j=0; j<Ny+1; j++ ){
      vel[i][j] = 1.0;
      //cout << "v[" << i << "][" << j << "] = " << vel[i][j] << endl;
    }
  }
  
  // lado derecho
  for( int i=(Nx+1)/2; i<Nx+1; i++ ){
    for( int j=0; j<(Ny+1)/2; j++ ){
      vel[i][j] = 0.4;
    }
    for( int j=(Ny+1)/2; j<Ny+1; j++ ){
      vel[i][j] = 1.0;
    }
  }
  

  // Fijar dt
  dt = 0.5 * dx / 1.0;
  

  // coordenada x
  for( int i=0; i<Nx+1; i++ )
    x[i] = i*dx;

    // coordenada y
  for( int i=0; i<Ny+1; i++ )
    y[i] = i*dx;

  cout << "dx = "<< dx << endl;
  cout << "dt = "<< dt << endl;

  
  // condiciones iniciales
  condiciones_iniciales( u_vieja, u, Nx, Ny, x, y, dt );


  // condicion de frontera
  condiciones_frontera( u_vieja, Nx, Ny, x, y, tiempo);
  condiciones_frontera( u, Nx, Ny, x, y, tiempo);

  
  tiempo += dt;
  
  // ciclo principal
  for( int k=0; k<=Niter; k++ ){

#pragma omp parallel for collapse(2)
    for( int i=1; i<Nx; i++ ){
      for( int j=1; j<Ny; j++ ){
	alfa = vel[i][j]*dt/dx;
	//cout << "alfa = "<< alfa << endl;
	u_nueva[i][j] = 2.*u[i][j] - u_vieja[i][j] + alfa*alfa*
	  (u[i-1][j] + u[i+1][j] + u[i][j-1] + u[i][j+1] - 4.*u[i][j] );
      }
    }
    // condicion de frontera
    condiciones_frontera( u_nueva, Nx, Ny, x, y, tiempo + dt);
    

    // cambiar instantes de tiempo
#pragma omp parallel for collapse(2)
    for(int i=0; i<Nx+1; i++ ){
      for( int j=0; j<Ny+1; j++ ){
	u_vieja[i][j] = u[i][j];
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



void condiciones_iniciales( double **u_vieja, double **u, int Nx, int Ny, double *x, double *y, double dt )
{
  for( int i=0; i<Nx+1; i++ ){
    for( int j=0; j<Ny+1; j++ ){
      u_vieja[i][j] = f_cond_ini( x[i], y[j] );
      u[i][j]       = u_vieja[i][j] +  g_cond_ini( x[i], y[j] )*dt;
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
  return 0.0;
}

double p2( double x, double t )
{
  return 0.0;
}


double q1( double y, double t )
{
  double w = 400;
  double omega = 50.0;
  double s = 20.0; // atenuacion en el tiempo
  double Ly = 1.0; // longitud en y

  return ( exp(-pow(w*(y-0.25*Ly),2)) + exp(-pow(w*(y-0.75*Ly),2))   ) * sin( omega*t ) * exp( -s*t );

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



