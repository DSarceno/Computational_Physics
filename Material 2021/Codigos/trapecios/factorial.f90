!    2017-08-12
!    factorial.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementación del cálculo del factorial usando funciones iterativas y
!    recursivas

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o factorial.o factorial.f90

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

! función factorial (implementación recursiva)
! ENTRADA: un valor entero
! SALIDA: un valor entero, el resultado del factorial
RECURSIVE FUNCTION FactorialR(n)  RESULT(Fact)
  ! esta función es típica de los cursos de programación, hay una forma
  ! iterativa y una recursiva para implementar el factorial.  Si hay dudas,
  ! hay que revisar cualquier referencia básica de programación.
  USE TYPES,ONLY:I4B
  IMPLICIT NONE
  INTEGER(I4B), INTENT(IN) :: n ! el valor de entrada
  ! variable que se regresa, en las funciones recursivas no se recomienda usar
  ! el mismo nombre de la función
  INTEGER(I4B) :: Fact

  ! ciclo principal
  IF (n == 0) THEN
     Fact = 1 ! por definición, el factorial de 0 es 1
  ELSE
     Fact = n * FactorialR(n-1) ! calcular el factorial de n-1
  END IF
END FUNCTION FactorialR


! funcion factorial (implementación iterativa)
! ENTRADA: un valor entero
! SALIDA: un valor entero, el resultado del factorial
FUNCTION FactorialI(n)
  ! esta función es típica de los cursos de programación, hay una forma
  ! iterativa y una recursiva para implementar el factorial.  Si hay dudas,
  ! hay que revisar cualquier referencia básica de programación.
  USE types,ONLY:I4B
  IMPLICIT NONE
  INTEGER(I4B),INTENT(IN)::  n ! valor de entrada para calcular
  INTEGER(I4B):: FactorialI ! variable de salida

  ! variables auxiliares
  INTEGER(I4B)::i

  FactorialI=1
  DO i=1,n
     FactorialI=FactorialI*i
  END DO
END FUNCTION FactorialI

