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

PUBLIC mGen, expFile

CONTAINS
  FUNCTION mGen(a,b) RESULT(M)
    IMPLICIT NONE

    ! Dimensiones de la matriz "axb"
    INTEGER, INTENT(IN) :: a, b
    ! matriz a devolver
    INTEGER, DIMENSION(a,b) :: M
    ! matriz de números reales aleatorios
    INTEGER :: i, J  ! iterador
    REAL, DIMENSION(a,b) :: Transition
    ! Seed
    INTEGER :: base
    INTEGER, ALLOCATABLE,DIMENSION(:) :: seed
    INTEGER :: s


    ! Variable error
    INTEGER :: err
    M = 0

    ! Leer la base
    OPEN(21,FILE="seed.in",STATUS="OLD",IOSTAT=err)
    IF (err.EQ.0) THEN
      READ(21,*) base
      CLOSE(21)
    END IF

    ! Tamaño optimo para el seed
    CALL RANDOM_SEED(SIZE = s)
    ! allocate seed
    ALLOCATE(seed(s), STAT=err)
    IF (err.NE.0) STOP 'Memoria no reservada'
    ! Generador de números para el seed
    seed = base + 37 * (/ (i-1,i=1,s) /)
    CALL RANDOM_SEED(PUT = seed)
    DEALLOCATE(seed)

    CALL RANDOM_NUMBER(Transition)


    ! Rango de números 0-base
    DO i = 1,a
      DO j = 1,b
        M(i,j) = FLOOR(base*Transition(i,j))
      END DO
    END DO

  END FUNCTION mGen
END MODULE matrixGenerator
































! END
