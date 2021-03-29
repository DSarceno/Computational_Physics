!    2021-03-28
!    matrixGenerator.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Este módulo contiene la funcion "mGen" la cual recibe como valores las
!    dimensiones de una matriz y genera dicha matriz con múmeros enteros
!    aleatorios, el rango de dichos enteros se puede modificar, asi como
!    el hecho de ser enteros.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o matrixGenerator.o matrixGenerator.f95

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
MODULE matrixGenerator

PUBLIC mGen

CONTAINS
  FUNCTION mGen(a,b) RESULT(matrix)
    IMPLICIT NONE

    INTEGER, INTENT(IN) :: a, b


  END FUNCTION mGen



END MODULE matrixGenerator
