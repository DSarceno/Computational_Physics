!    2019-02-04
!    mergeSort.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementar el algoritmo merge-sort (o mergesort, o Merge Sort) para
!    ordenar numeros enteros de modo ascendente.  Procedimiento didactico
!    adaptado del codigo MergeSort del proyecto OWLS

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.3.1, GNU Fortran
!    (Debian 4.7.2-5) 4.7.2
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o mergeSort.o mergeSort.f90
!    gfortran -o mergeSort.x mergeSort.o 

!    Copyright (C) 2019
!    A. G. Ramirez Garcia
!    ramirez@ecfm.usac.edu.gt
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

PROGRAM TESTmergeSort

  IMPLICIT NONE
  ! variables del problema
  INTEGER(4):: NumeroDatos ! numero de datos
  INTEGER(4),ALLOCATABLE,DIMENSION(:):: Lista ! lista a ordenar

  ! otras variables
  INTEGER(4),ALLOCATABLE,DIMENSION(:):: working ! espacio de trabajo
  INTEGER(4):: i ! contadores
  INTEGER(4):: err ! para guardar errores

  ! leer los numeros desde un archivo, la primera linea dice el tamanno y los
  ! numeros empiezan en la segunda linea
  OPEN(21,FILE="datos",STATUS="OLD",IOSTAT=err)
  IF (err.EQ.0) THEN
     READ(21,*) NumeroDatos
     IF (NumeroDatos.GT.1) THEN
        ALLOCATE(Lista(NumeroDatos),STAT=err)
        IF (err.NE.0) STOP 'Memoria no reservada'
        ALLOCATE(working((NumeroDatos+1)/2),STAT=err)
        IF (err.NE.0) STOP 'Memoria no reservada'
        DO i=1,NumeroDatos
           READ(21,*,IOSTAT=err) Lista(i)
           IF (err.NE.0) STOP 'No se encontro el numero'
        END DO
     ELSE
        STOP 'Necesita por lo menos dos numeros'
     END IF
     CLOSE(21)   
  ELSE
     STOP 'Archivo no encontrado'
  END IF

  ! encabezados
  WRITE (*,*) "# Merge sort"
  WRITE (*,*) "# Lista original"
  WRITE (*,*) Lista

  ! algoritmo Merge sort
  CALL MergeSort(Lista,NumeroDatos,working)

  ! mostrar la lista ordenada
  WRITE (*,*) "# Lista ordenada"
  WRITE (*,*) Lista

  ! liberar memoria
  DEALLOCATE(Lista)
  DEALLOCATE(working)
CONTAINS
  SUBROUTINE merge(L,sL,R,sR,W,sW)
    IMPLICIT NONE
    INTEGER(4),INTENT(IN)::sW,sR,sL
    INTEGER(4),DIMENSION(sL),INTENT(IN OUT):: L
    INTEGER(4),DIMENSION(sW),INTENT(IN OUT):: W
    INTEGER(4),DIMENSION(sR),INTENT(IN)::     R
    !local
    INTEGER(4)::i,j,k

    i=1
    j=1
    k=1
    DO WHILE (i.LE.sL.AND.j.LE.sR)
       IF (L(i).LE.R(j)) THEN
          W(k)=L(i)
          i=i+1
       ELSE
          W(k)=R(j)
          j=j+1
       END IF
       k=k+1
    END DO

    DO WHILE (i.LE.sL)
       W(k)=L(i)
       i=i+1
       k=k+1
    END DO
    RETURN
  END SUBROUTINE merge

  RECURSIVE SUBROUTINE MergeSort(X,sX,W)
    IMPLICIT NONE
    INTEGER(4)::sX
    INTEGER(4),DIMENSION(sX),INTENT(IN OUT)::    X 
    INTEGER(4),DIMENSION((sX+1)/2),INTENT(OUT):: W 
    !local
    INTEGER(4)::nL,nR 
    INTEGER(4):: tmp 
  
    IF (sX.LT.2) RETURN !!!!!! important step to finish recursive calls
    WRITE (*,*) X ! esto es para mostrar que subcadena esta ordenando
    IF (sX.EQ.2) THEN
       IF (X(1).GT.X(2)) THEN
          tmp=X(1)
          X(1)=X(2)
          X(2)=tmp
       END IF
       RETURN
    END IF

    nL=(sX+1)/2     !!!! divide step
    nR=sX-nL
    CALL MergeSort(X,nL,W)
    CALL MergeSort(X(nL+1),nR,W)

    IF (X(nL).GT.X(nL+1)) THEN  !!! conquer step
       W(1:nL)=X(1:nL)
       CALL Merge(W,nL,X(nL+1),nR,X,sX)
    END IF
    RETURN
  END SUBROUTINE MergeSort

END PROGRAM TESTmergeSort
