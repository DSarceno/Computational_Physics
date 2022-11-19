//======================================================
//
// Ejemplo de cómo funcionan las variables, referencias
// y punteros en C++
//
//======================================================

#include <iostream>

using namespace std;

int main()
{
  // variable
  double A = 3.1416;
  cout << "A="<<A << endl;

  // copia de variables
  double B = A;
  cout << "B = " << B << endl;

  cout << "&A = " << &A << endl;
  cout << "&B = " << &B << endl;

  // C es una refencia A
  double &C = A;

  cout << "C = " << C << endl;
  cout << "&C = " << &C << endl;

  C = 8.32;
  cout << "C = " << C << endl;
  cout << "A = " << A << endl;

  // D es un puntero hacia A
  double *D = &A;
  cout << "&D = " << &D << endl;
  cout << " D = " << D << endl;
  cout << "*D = " << *D << endl;

  
  *D = 7.8;
  cout << "*D = " << *D << endl;
  cout << " A = " << A << endl;

  //double *F = 9.7;

  return 0;
}
