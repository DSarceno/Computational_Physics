!    2017-10-11
!    randomTEST.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Prueba de la generación de variables aleatorias tomada del proyecto OWLS.
!    La idea es probar $\int_0^1 f(x) dx$ cuando f(x) es una función de
!    distribución, por ejemplo $f(x)=x^p$.  El algoritmo busca en el archivo
!    "seed.in" una base para generar una semilla, si la base es cero o si el
!    archivo no existe, el algoritmo elige una base en función del tiempo.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere types.f90, factorial.f90,
!    besselJ.f90 y funciones.f90
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o randomTEST.o randomTEST.f90
!    gfortran -Wall -pedantic -std=f95 -o randomTEST.x types.o randomTEST.o

!    Copyright (C) 2017
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

PROGRAM randomTEST
  USE types
  IMPLICIT NONE

  ! Variables del problema
  REAL(FP):: p   ! potencia
  REAL(FP):: S   ! suma
  INTEGER(I4B):: n ! para la dimensión de la semilla
  INTEGER(I4B):: base ! para la base de la semilla
  INTEGER(I4B):: runs ! para la cantidad de lanzamientos
  REAL(FP),ALLOCATABLE,DIMENSION(:):: x   ! variable aleatoria
  INTEGER(I4B),ALLOCATABLE,DIMENSION(:)::seed ! para la semilla

  ! Variables extra
  INTEGER(I4B)::i   ! contador
  INTEGER(I4B)::err ! error

  ! Leer datos del número de lanzamientos, default 100
  OPEN(21,FILE="config.in",STATUS="OLD",IOSTAT=err)
  IF (err.EQ.0) THEN
     READ(21,*) p
     READ(21,*) runs
     CLOSE(21)
  ELSE
     p=1.0
     runs=100
  END IF
  ! reservar memoria para x
  ALLOCATE(x(runs),STAT=err)
  IF (err.NE.0) STOP 'Memoria no reservada'

  ! Leer datos del archivo, si no hay archivo usar la base cero
  OPEN(21,FILE="seed.in",STATUS="OLD",IOSTAT=err)
  IF (err.EQ.0) THEN
     READ(21,*) base
     CLOSE(21)
  ELSE
     base=0
  END IF
  ! si se lee un cero, usar el reloj
  IF (base.EQ.0) THEN
     CALL SYSTEM_CLOCK(COUNT=base)
  END IF
  WRITE (*,*) "# Base: ",base

  ! recuperar el tamaño adecuado para de la semilla para usar en el sistema
  CALL RANDOM_SEED(SIZE=n)
  ! dimensionar la semilla
  ALLOCATE(seed(n),STAT=err)
  IF (err.NE.0) STOP 'Memoria no reservada'
  ! determinar la semilla, el 37 es un número cualquiera y la notación entre
  ! paréntesis es un ciclo que usa la variable i-1 desde i=1 hasta i=n
  seed=base +37 *(/ (i-1,i=1,n) /)
  ! fijar la semilla
  CALL RANDOM_SEED(PUT=seed)
  ! liberar la memoria usada para la semilla
  DEALLOCATE(seed)

  ! Llenar el arreglo con números aleatorios entre 0 y 1 tomados de una
  ! función de distribución uniforme
  CALL RANDOM_NUMBER(x)

  ! Hacer la integración
  S=0.
  DO i=1,runs
     S=S+x(i)
  END DO
  ! Normalizar en función del número de realizaciones
  S=S/REAL(runs)

  WRITE (*,*) runs, S

END PROGRAM randomTEST



