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
  FUNCTION primes (n) RESULT(prime)
    IMPLICIT NONE

    INTEGER, INTENT(IN) :: n      ! Entero ingresado en la función
    INTEGER :: j
    LOGICAL :: prime

    IF (n.NE.1) THEN
      prime = .TRUE.
    END IF


    DO j = 2,CEILING(SQRT(REAL(n)))
      IF ((MOD(n,j).EQ.0) .AND. (j.NE.n)) THEN
        prime = .FALSE.
      END IF
    END DO


    IF (prime.NEQV. .FALSE.) THEN
      prime = .TRUE.
    END IF

  END FUNCTION primes

END MODULE functions
