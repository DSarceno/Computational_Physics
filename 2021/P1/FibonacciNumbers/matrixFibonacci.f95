!    2021-01-30
!    matrixFibonacci.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa <program>

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o matrixFibonacci.o matrixFibonacci.f95
!    gfortran -o matrixFibonacci.x matrixFibonacci.o

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
PROGRAM matrixFibonacci
IMPLICIT NONE
  ! matrices
  INTEGER(16), DIMENSION(2,2) :: F, step, nF
  ! iteradores
  INTEGER(16) :: l
  ! n-esimo número
  INTEGER(16) :: n
  ! variable de error
  INTEGER :: err


  ! matriz inicial
  F = 1
  F(2,2) = 0


  ! Número deseado
  OPEN(12,FILE = 'n.in', STATUS = 'OLD', IOSTAT = err)
  IF (err.EQ.0) THEN
    READ(12,*) n
    CLOSE(12)
  ELSE
    WRITE(*,*) 'No se encontró el archivo'
  END IF

  ! PRODUCTO DE MATRICES
  step = F ! matriz paso para almacenar la siguiente matriz a multiplicar
  nF = 0 ! matriz de almacenamiento
  DO l = 1,n
    nF = MATMUL(F,step)
    step = nF
  END DO

  WRITE(*,*) nF(2,2) ! termino que representa el n-esimo número de fibonacci


END PROGRAM matrixFibonacci

































! END
