!    2017-08-07
!    pool.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementación de la función para usar en la regla del trapecio.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere types.f90, factorial.f90,
!    besselJ.f90 y funciones.f90
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o funciones.o funciones.f90
!    gfortran -Wall -pedantic -std=f95 -c -o factorial.o factorial.f90
!    gfortran -Wall -pedantic -std=f95 -c -o besselJ.o besselJ.f90
!    gfortran -Wall -pedantic -std=f95 -c -o pool.o pool.f90

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


MODULE pool

  INTERFACE f
     FUNCTION f1(x)
       ! función polinómica
       ! ENTRADA: un valor real donde se quiere evaluar la función
       ! SALIDA: un valor real, el resultado de evaluar la función
       USE types,ONLY:FP
       IMPLICIT NONE
       REAL(FP),INTENT(IN)::x
       REAL(FP)::f1
     END FUNCTION f1
  END INTERFACE f


  INTERFACE Factorial
     ! función factorial (implementación recursiva)
     ! ENTRADA: un valor entero
     ! SALIDA: un valor entero, el resultado del factorial
     RECURSIVE FUNCTION FactorialR(n)  RESULT(Fact)
       USE TYPES,ONLY:I4B
       IMPLICIT NONE
       INTEGER(I4B), INTENT(IN) :: n ! el valor de entrada
       ! variable que se regresa, en las funciones recursivas no se recomienda usar
       ! el mismo nombre de la función
       INTEGER(I4B) :: Fact
     END FUNCTION FactorialR
  END INTERFACE Factorial


  INTERFACE
     ! subrutina factorial (implementación iterativa)
     ! ENTRADA: un valor entero y una variable entera para guardar el resultado
     ! SALIDA: un valor entero, el resultado del factorial
     FUNCTION FactorialI(n)
       USE types,ONLY:I4B
       IMPLICIT NONE
       INTEGER(I4B),INTENT(IN)::  n ! valor de entrada para calcular
       INTEGER(I4B):: FactorialI ! variable de salida
     END FUNCTION  FactorialI
  END INTERFACE


  ! función de Bessel, forzando a que el orden n sea entero
  ! ENTRADA: un valor real y uno entero para calcular la función de Bessel de
  ! orden entero
  ! SALIDA: un valor real con el valor de la función de Bessel
  INTERFACE
     FUNCTION J(n,x)
       USE types,ONLY:FP,I4B
       IMPLICIT NONE
       INTERFACE
          RECURSIVE FUNCTION FactorialR(n)  RESULT(Fact)
            USE TYPES,ONLY:I4B
            IMPLICIT NONE
            INTEGER(I4B), INTENT(IN) :: n 
            INTEGER(I4B) :: Fact 
          END FUNCTION FactorialR
       END INTERFACE
       INTEGER(I4B),INTENT(IN)::n  ! para el orden de la función de Bessel
       REAL(FP),INTENT(IN)::x ! para la evaluación de la función de Bessel
       REAL(FP)::J  ! nombre de la función para devolver el resultado
     END FUNCTION J
  END INTERFACE

END MODULE pool
