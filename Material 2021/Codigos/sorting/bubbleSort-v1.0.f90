!    2019-02-04
!    bubbleSort-v1.0.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementar la optimizacion del algoritmo bubble-sort (o bubblesort, o
!    Bubble Sort) para ordenar numeros enteros de modo ascendente.  Para una
!    version con mas informacion de salida ver bubbleSort-v1.1.f90.  Para una
!    version sin la optimizacion ver bubbleSort-v0.*.f90

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.3.1, GNU Fortran
!    (Debian 4.7.2-5) 4.7.2
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o bubbleSort-v1.0.o bubbleSort-v1.0.f90
!    gfortran -o bubbleSort-v1.0.x bubbleSort-v1.0.o 

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

PROGRAM bubbleSort

  IMPLICIT NONE
  ! variables del problema
  LOGICAL :: Swapped ! para saber si se hacen intercambios
  INTEGER(4):: NumeroDatos ! numero de datos
  INTEGER(4),ALLOCATABLE,DIMENSION(:):: Lista ! lista a ordenar

  ! otras variables
  INTEGER(4):: tmp ! variable temporal para hacer el intercambio
  INTEGER(4):: i,j ! contadores
  INTEGER(4):: err ! para guardar errores

  ! leer los numeros desde un archivo, la primera linea dice el tamanno y los
  ! numeros empiezan en la segunda linea
  OPEN(21,FILE="datos",STATUS="OLD",IOSTAT=err)
  IF (err.EQ.0) THEN
     READ(21,*) NumeroDatos
     IF (NumeroDatos.GT.1) THEN
        ALLOCATE(Lista(NumeroDatos),STAT=err)
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
  WRITE (*,*) "# Bubble sort"
  WRITE (*,*) "# Lista original"
  WRITE (*,*) Lista

  ! El algoritmo Buble sort compara pares de numeros en toda la lista para
  ! ordenarlos y se detiene cuando ya no hay mas intercambios.  La version
  ! optimizada no vuelve a comparar los valores que ya estan ordenados.  Los
  ! valores ya ordenados incrementan uno a uno con el numero de veces que
  ! pasamos por la lista completa
  j=NumeroDatos
  ! 1. El algoritmo debe hacer una comparacion ordenada, e.g. de izquierda a
  ! derecha o viceversa. Vamos a iniciar con la hipotesis de que la lista no
  ! esta ordenada, i.e. evaluamos el mejor caso O(n)
  Swapped=.TRUE.
  DO WHILE (Swapped.NEQV..FALSE.)
  ! 2. Asignar un valor falso a la variable logica, esto hace que verifiquemos
  ! si se mantiene la hipotesis
     Swapped=.FALSE.
  ! 3. Evaluar si cada par en la sublista está ordenado: vamos de izquierda a
  ! derecha
     DO i=1,j-1
  ! 3.1 Comparar si el par de numeros esta ordenado, si no esta ordenado,
  ! intercambiarlos y cambiar la variable logica para decir que hicimos un
  ! intercambio
        IF (Lista(i).GT.Lista(i+1)) THEN
           tmp=Lista(i)
           Lista(i)=Lista(i+1)
           Lista(i+1)=tmp
           Swapped=.TRUE.
        END IF
     END DO
  ! 4. Hay que actualizar el numero de valores que ya estan ordenados
     j=j-1
  ! 5. Parar si y solo si la variable logica sigue siendo falsa, i.e. ya no se
  ! hicieron intercambios
  END DO
  ! mostrar la lista ordenada
  WRITE (*,*) "# Lista ordenada"
  WRITE (*,*) Lista

  ! liberar memoria
  DEALLOCATE(Lista)

END PROGRAM bubbleSort
