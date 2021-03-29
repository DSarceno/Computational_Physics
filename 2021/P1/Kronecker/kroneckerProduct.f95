!    2021-03-28
!    kroneckerProduct.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa <program>

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: requiere matrixGenerator.f95
!    gfortran -Wall -pedantic -std=f95 -c -o matrixGenerator.o matrixGenerator.f95
!    gfortran -Wall -pedantic -std=f95 -c -o kroneckerProduct.o kroneckerProduct.f95
!    gfortran -o kroneckerProduct.x matrixGenerator.o kroneckerProduct.o

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

PROGRAM kroneckerProduct
USE matrixGenerator
IMPLICIT NONE

  ! creando dos matrices de dimensiones mxn y pxq
  REAL(8), ALLOCATABLE, DIMENSION(:,:) :: M1, M2, R
  ! Dimensiones
  INTEGER :: n,m,p,q
  ! iteradores
  INTEGER :: i,j,k,l

  INTEGER :: err



  INTEGER, ALLOCATABLE,DIMENSION(:) :: seed
  INTEGER :: s
  REAL, ALLOCATABLE, DIMENSION(:) :: x

  ALLOCATE(x(100),STAT=err)
  IF (err.NE.0) STOP 'Memoria no reservada'


  ! Dimensiones de las matrices
  m = 2
  n = 2
  p = 3
  q = 3


  ALLOCATE(M1(m,n),STAT=err)
  IF (err.NE.0) STOP "Memoria no reservada"


  ! matriz 1, matriz de pauli z
  M1 = 0
  M1(1,1) = 1
  M1(2,2) = -1
  !WRITE(*,*) M1


  ALLOCATE(M2(p,q),STAT=err)
  IF (err.NE.0) STOP "Memoria no reservada"

  ! matriz 2
  M2 = 0
  M2(1,2) = 1
  M2(2,1) = 1
  M2(2,3) = 1
  M2(3,2) = 1
  !WRITE(*,*) M2

  ! Producto de kronecker
  ALLOCATE(R(m*p,n*q),STAT=err)
  IF (err.NE.0) STOP "Memoria no reservada"

  DO i = 1,m                    ! Iterador sobre las filas de M1
    DO j = 1,n                  ! Iterador sobre las columnas de M1
      DO k = 1,p                ! Iterador sobre las filas de M2
        DO l = 1,q              ! Iterador sobre las columnas de M2
          ! Para la coordenada "alpha" es construida con "p*(i - 1) + k"
          ! Para la coordenada "beta" es construida con "q*(j - 1) + l"
          R(p*(i - 1) + k, q*(j - 1) + l) = M1(i,j)*M2(k,l)
        END DO
      END DO
    END DO
  END DO


! Creando archivo con la matriz resultante
  DO i = 1, m*p
    WRITE(99,*) INT(R(i,1)), INT(R(i,2)), INT(R(i,3)), INT(R(i,4)), &
                  & INT(R(i,5)), INT(R(i,6))
  END DO
  CLOSE(99)

  WRITE(98,*) R
  CLOSE(98)


  CALL RANDOM_SEED(SIZE = s)

  ALLOCATE(seed(s), STAT=err)
  IF (err.NE.0) STOP 'Memoria no reservada'
  seed = 100 + 37 * (/ (i-1,i=1,s) /)
  CALL RANDOM_SEED(PUT = seed)
  WRITE(*,*) seed
  DEALLOCATE(seed)




  CALL RANDOM_NUMBER(x)

  WRITE(*,*) x

  WRITE(*,*) mGen(2,2)



END PROGRAM kroneckerProduct


















































! END
