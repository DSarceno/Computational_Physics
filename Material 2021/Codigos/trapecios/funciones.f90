!    2017-08-08
!    funciones.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementación de las funciones para usar en el método del trapecio y en
!    el método de Euler

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o funciones.o funciones.f90

!    Copyright (C) 2017
!    A. G. Ramirez Garcia
!    ramirez@ecfm.usac.edu.gt
!
!    This program is free software: you can redistribute it and/or
!    modify it under the terms of the GNU General Public License as
!    published by the Free Software Foundation, either version 3 of
!    the License, or (at your option) any later version.
!
!    This program is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
!    General Public License for more details.
!
!    You should have received a copy of the GNU General Public License
!    along with this program.  If not, see
!    <http://www.gnu.org/licenses/>.
!

! función polinómica
! ENTRADA: un valor real donde se quiere evaluar la función
! SALIDA: un valor real, el resultado de evaluar la función
FUNCTION f1(x)
  USE types,ONLY:FP
  IMPLICIT NONE
  REAL(FP),INTENT(IN)::x  ! variable para la evaluación de la función
  REAL(FP)::f1  ! nombre de la función para devolver el resultado

  ! función de prueba y=f(x)=4x^2+1. La traducción de estas fórmulas a
  ! código de fortran es una de las grandes ventajas de Fortran
  ! f1=4*x**2+1

  ! funciones de prueba
  f1=1 ! a=0, b=1, n=4, S=1
  ! f1=x ! a=0, b=1, n=4, S=0.5
  RETURN 
END FUNCTION f1
