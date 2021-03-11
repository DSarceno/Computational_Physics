!    2021-03-10
!    goldbachCongeture.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Demostración computacional de la conjetura de Goldbach

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: requiere functions.f95
!    gfortran -Wall -pedantic -std=f95 -c -o functions.o functions.f95
!    gfortran -Wall -pedantic -std=f95 -c -o goldbachCongeture.o goldbachCongeture.f95
!    gfortran -o goldbachCongeture.x functions.o goldbachCongeture.o

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

PROGRAM goldbachCongeture
  USE functions

  IMPLICIT NONE

  INTEGER :: i


  DO i = 1,20
    WRITE(*,*) i,primes(i)
  END DO



END PROGRAM goldbachCongeture
