!    2017-08-12
!    holaMundoP.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Programa hola mundo en paralelo

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: no requiere nada mas
!    mpifort -Wall -pedantic -std=f95 -c -o holaMundoP.o holaMundoP.f90
!    mpifort -o holaMundoP.x holaMundoP.o 
!    mpirun -np 5 ./holaMundoP.x
!    mpirun -f mpd.hosts ./holaMundoP.x

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

PROGRAM hola

  ! INCLUDE "mpif.h" ! esta forma también es válida pero no en el estándar de
  ! FORTRAN 95
  USE mpi ! para incluir las bibliotecas de programación en paralelo
  IMPLICIT NONE
  
  !variables para MPI
  INTEGER :: rank, size

  ! variables auxiliares
  INTEGER :: err


  ! iniciando MPI, esto habilita el entorno de trabajo
  CALL MPI_Init(err)
  IF (err.NE.0) STOP 'MPI_Init error' ! esto es programación defensiva

  ! hay varios parámetros que el programa debe conocer en tiempo real, por
  ! ejemplo tiene que conocer de cuántos nodos se dispone y quién es cada nodo
  CALL MPI_Comm_rank(MPI_COMM_WORLD,rank,err) ! dice a cada nodo quién es
  IF (err.NE.0) STOP 'MPI_Comm_rank error' ! esto es programación defensiva

  CALL MPI_Comm_size(MPI_COMM_WORLD,size,err) ! dice cuántos nodos hay
  IF (err.NE.0) STOP 'MPI_Comm_size error' ! esto es programación defensiva

  WRITE (*,*) "Hola mundo, soy:",rank," de ",size

  ! terminando MPI, esto deshabilita el entorno de trabajo
  CALL MPI_Finalize(err)
  IF (err.NE.0) STOP 'MPI_Init error'

END PROGRAM hola





! Hola mundo, soy: 0 de 4
! Hola mundo, soy: 1 de 4
! Hola mundo, soy: 2 de 4
! Hola mundo, soy: 3 de 4

