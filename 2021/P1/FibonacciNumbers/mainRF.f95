!    2021-01-30
!    mainRF.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa de utilización de la función recursiva.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: requiere 'recursiveFibonacci.f95'
!    gfortran -Wall -pedantic -std=f95 -c -o recursiveFibonacci.o recursiveFibonacci.f95
!    gfortran -Wall -pedantic -std=f95 -c -o mainRF.o mainRF.f95
!    gfortran -o mainRF.x  recursiveFibonacci.o mainRF.o

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
PROGRAM mainRF
  USE recursive
  IMPLICIT NONE

  INTEGER(16) :: n
  INTEGER :: err

  OPEN(12, FILE = 'n.in', STATUS = 'OLD', IOSTAT = err)
  IF (err.EQ.0) THEN
    READ(12,*) n
    CLOSE(12)
  ELSE
    WRITE(*,*) 'No se encuentra el archivo'
  END IF


  WRITE(*,*) fibonacciR(n)
END PROGRAM mainRF
