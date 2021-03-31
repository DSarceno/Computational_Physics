!    2021-01-30
!    recursiveFibonacci.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa función de la implementación recursiva para encontrar el n-esimo
!    número de fibonacci.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o recursiveFibonacci.o recursiveFibonacci.f95

!    Copyright (C) 2021
!    D. R. Sarceño Ramírez
!    dsarceno68@gmail.com
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
MODULE recursive

PUBLIC fibonacciR

CONTAINS

  RECURSIVE FUNCTION fibonacciR(n) RESULT(fib)
    IMPLICIT NONE

    INTEGER(16), INTENT(IN) :: n
    INTEGER(16) :: fib

    IF (n.LE.2) THEN
      fib = 1
    ELSE
      fib = fibonacciR(n - 1) + fibonacciR(n - 2)
    END IF


  END FUNCTION fibonacciR
END MODULE recursive
