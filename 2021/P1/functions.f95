!    2021-03-10
!    functions.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Función que determina si cierto número n es primo

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o functions.o functions.f95

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
MODULE functions

PUBLIC primes

CONTAINS
  FUNCTION primes (n)
    IMPLICIT NONE

    INTEGER, INTENT(IN) :: n      ! Entero ingresado en la función
    INTEGER :: primes             ! Valor retornado de la función
    INTEGER :: j, limit

    limit = CEILING(SQRT(REAL(n)))

    primes = 1

    IF (n.EQ.1) THEN              ! En caso de que el número ingresado sea 1
      primes = 0                    ! se devolverá 0 como señal de que no es primo
    END IF

    DO j = 1, limit
      IF ((MOD(n,j).EQ.0) .OR. (j.NE.n)) THEN
        primes = 0
      END IF
    END DO


    IF (primes.EQ.1) THEN
      primes = n
    END IF

  END FUNCTION primes

END MODULE functions
