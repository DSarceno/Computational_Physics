!    2021-03-28
!    kroneckerProduct.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa del archivo "dim.in" toma las dimensiones de las matrices que se
!    desea generar, si dicho archivo no existe, se toman dos matrices predeterminadas.
!    Se requiere del módulo "matrixGenerator.f95" el cual toma las dimensiones de una
!    matriz y genera dicha matriz en base a números aleatorios y una semilla creada
!    con la base en el archivo "seed.in". Con las matrices creadas se encuentra el
!    producto tensorial de Kronecker entre ambas matrices.

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
  ! Variable de error
  INTEGER :: err
  ! Para escribir el archivo con la matriz
  INTEGER, ALLOCATABLE, DIMENSION(:) :: rowVector


  ! Dimensiones de las matrices
  OPEN(12,FILE = 'dim.in',STATUS = 'OLD', IOSTAT = err)
  IF (err.EQ.0) THEN
    READ(12,*) m
    READ(12,*) n
    READ(12,*) p
    READ(12,*) q
    CLOSE(12)

    ! matriz 1
    ALLOCATE(M1(m,n),STAT=err)
    IF (err.NE.0) STOP "Memoria no reservada"

    M1 = mGen(m,n)


    ! matriz 2
    ALLOCATE(M2(p,q),STAT=err)
    IF (err.NE.0) STOP "Memoria no reservada"

    M2 = mGen(p,q)
  ELSE ! en caso de que no exista el archivo, se toman dos matrices predeterminadas
    m = 2
    n = 2
    p = 3
    q = 3
    ! MATRICES DE PRUEBA
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
    ! FIN DE MATRICES DE PRUEBA
  END IF


  ! Producto de kronecker
  ALLOCATE(R(m*p,n*q),STAT=err)
  IF (err.NE.0) STOP "Memoria no reservada"


  R = 0

  ! Se realizar 4 ciclos para navegar por cada una de los elementos de cada matriz
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

  ! Representacion de la matriz resultante en un archivo "fort.11"
  ! vector para escribir las filas en dicho archivo
  ALLOCATE(rowVector(n*q), STAT = err)
  IF (err.NE.0) STOP 'Memoria no reservada'

  rowVector = 0

  ! Escritura del archivo
  DO i = 1,m*p
    DO j = 1,n*q
      rowVector(j) = INT(R(i,j))
    END DO
    WRITE(11,*) rowVector
  END DO
  CLOSE(11)

END PROGRAM kroneckerProduct


















































! END
