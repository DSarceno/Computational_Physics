!    2017-8-21
!    trapecioP.f90
!    Giovanni Ramirez (ramirez@ecfm.usac.edu.gt)

!    Implementación de la regla del trapecio para la integración numérica con
!    el objetivo de mostrar la programación en paralelo. Ver J. Douglas
!    Faires, Richard L. Burden, "Numerical Methods" 4th, Cengage Learning,
!    2012.

!    Codificación: UTF-8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere types.f90 y pool.f90
!    mpifort -Wall -pedantic -std=f95 -c -o types.o types.f90
!    mpifort -Wall -pedantic -std=f95 -c -o factorial.o factorial.f90
!    mpifort -Wall -pedantic -std=f95 -c -o besselJ.o besselJ.f90
!    mpifort -Wall -pedantic -std=f95 -c -o funciones.o funciones.f90
!    mpifort -Wall -pedantic -std=f95 -c -o pool.o pool.f90
!    mpifort -Wall -pedantic -std=f95 -c -o trapecioP.o trapecioP.f90
!    mpifort -o trapecioP.x types.o besselJ.o funciones.o factorial.o pool.o trapecioP.o

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


! iniciar el programa
PROGRAM trapecioP

  ! importar modulos
  USE types
  USE pool
  USE mpi

  IMPLICIT NONE
  ! definir variables del problema
  REAL(FP):: a,b ! limites
  INTEGER(I4B):: n ! oden de la funcion de Bessel
  REAL(FP):: limINF,limSUP ! limites
  REAL(FP):: Area   ! área

  ! definir variables mpi
  INTEGER(I4B):: size ! cuantos hilos
  INTEGER(I4B):: rank ! quién es cada uno

  ! definir variables control
  INTEGER(I4B):: err

  ! iniciar entorno mpi
  CALL MPI_Init(err) ! esto inicia el entorno
  IF (err.NE.0) STOP 'MPI_Init error'

  ! saber cuantos nodos hay
  CALL MPI_Comm_size(MPI_COMM_WORLD,size,err) ! dice cuántos nodos hay
  IF (err.NE.0) STOP 'MPI_Comm_size error' ! esto es programación defensiv

  ! saber el número de cada nodo
  CALL MPI_Comm_rank(MPI_COMM_WORLD,rank,err) ! dice a cada nodo quién es
  IF (err.NE.0) STOP 'MPI_Comm_rank error' ! esto es programación defensiva

  ! asignar a la unidad 12 un archivo de lectura, guardar el código de error
  OPEN(12,FILE="parametros.conf",STATUS="OLD",IOSTAT=err)
  IF (err.NE.0) STOP 'parametros no se ha encontrado'

  ! lectura de datos
  READ(12,*) ! esto es para quitar la línea del encabezado
  READ(12,*) a ! leer el límite a
  READ(12,*) b ! leer el límite b
  READ(12,*) n ! leer el órden de la función de bessel
  CLOSE(12)

  ! cálculo de límites
  limINF=a+REAL(rank)*(b-a)/REAL(size)
  limSUP=a+REAL(rank+1)*(b-a)/REAL(size)

  ! cálculo del área
  !Area=0.5*(b-a)/REAL(size)*(J(n,limINF)+J(n,limSUP))
  Area=0.5*(b-a)/REAL(size)*(f1(limINF)+f1(limSUP))

  ! escribir resultado en pantalla
  WRITE (*,*) "soy ", rank, "Limite inferior: ", limINF, "Limite superior: ",&
       limSUP,"Subtotal: ",Area

  ! terminar entorno mpi
  CALL MPI_FINALIZE(err) ! esto termina el entorno
  IF (err.NE.0) STOP 'MPI_Init error'  

END PROGRAM trapecioP




!! ejemplo del archivo de parametros
! 0 ! a
! 1 ! b
! 0 ! orden de la funcion bessel
