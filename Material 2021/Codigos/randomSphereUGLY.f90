!    2021-04-26
!    randomSphereUGLY.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Prueba de la generación de números aleatorios para verificar la
!    distribución uniforme sobre la superficie de una esfera

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.5
!    Instrucciones de compilación: requiere types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o randomSphereUGLY.o randomSphereUGLY.f90
!    gfortran -Wall -pedantic -std=f95 -o randomSphereUGLY.x types.o randomSphereUGLY.o

!    Copyright (C) 2021
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

PROGRAM randomSphereUGLY
  USE types
  IMPLICIT NONE

  ! variables del problema
  REAL(FP):: theta, phi ! coordenadas esféricas
  INTEGER(I4B):: runs   ! para la cantidad de pruebas

  ! varialebles para los números aleatorios
  INTEGER(I4B):: n    ! para la dimensión de la semilla
  INTEGER(I4B):: base ! para la base de la semilla
  INTEGER(I4B),ALLOCATABLE,DIMENSION(:)::seed ! para la semilla

  ! Variables extra
  REAL(FP),PARAMETER:: PI=3.14159265359
  INTEGER(I4B)::i   ! contador
  INTEGER(I4B)::err ! error

  ! Leer datos del número de lanzamientos, default 10
  OPEN(21,FILE="config.in",STATUS="OLD",IOSTAT=err)
  IF (err.EQ.0) THEN
     READ(21,*) runs
     CLOSE(21)
  ELSE
     runs=10
  END IF

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

  ! saludar
  WRITE (*,*) "# Coordenadas cartesianas obtenidas de la generación UGLY"
  WRITE (*,*) "# de 0<theta<2pi y 0<phi<pi "
  ! Generar los pares de números
  DO i=1,runs
     CALL RANDOM_NUMBER(theta)
     CALL RANDOM_NUMBER(phi)
     WRITE (*,*) phi*theta, phi*SIN(ACOS(theta)), COS(ASIN(phi))
  END DO

END PROGRAM randomSphereUGLY



