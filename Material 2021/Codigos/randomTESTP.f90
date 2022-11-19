!    2021-03-22
!    randomTEST.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Prueba de la generación de variables aleatorias tomada del proyecto OWLS
!    para programación en paralelo usando MPI. 

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.5.0
!    Instrucciones de compilación: requiere types.f90
!    mpifort -Wall -pedantic -std=f95 -c -o types.o types.f90
!    mpifort -Wall -pedantic -std=f95 -c -o randomTESTP.o randomTESTP.f90
!    mpifort -Wall -pedantic -std=f95 -o randomTESTP.x types.o randomTESTP.o

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

PROGRAM randomTESTP
  USE types
  USE mpi
  IMPLICIT NONE

  ! variables de MPI
  INTEGER(I4B)::size
  INTEGER(I4B)::rank
  INTEGER(I4B),DIMENSION(1:MPI_STATUS_SIZE)::status
  INTEGER(I4B)::emisor,receptor
  INTEGER(I4B)::tag
  
  ! variables para los números aleatorios
  INTEGER(I4B):: n ! para la dimensión de la semilla
  INTEGER(I4B):: base ! para la base de la semilla
  INTEGER(I4B),ALLOCATABLE,DIMENSION(:)::seed ! para la semilla

  ! variables para hacer un promedio
  INTEGER(I4B),PARAMETER::samples=100
  REAL(FP),ALLOCATABLE,DIMENSION(:):: x   ! variable aleatoria
  
  ! variables extra
  INTEGER(I4B)::i   ! contador
  INTEGER(I4B)::err ! error

  ! iniciar MPI
  CALL MPI_Init(err) ! esto inicia el entorno
  IF (err.NE.0) STOP 'MPI_Init error'

  ! saber cuantos hilos hay
  CALL MPI_Comm_size(MPI_COMM_WORLD,size,err) ! dice cuántos hilos hay
  IF (err.NE.0) STOP 'MPI_Comm_size error' 

  ! saber el número de cada hilo
  CALL MPI_Comm_rank(MPI_COMM_WORLD,rank,err) ! dice a cada hilo quién es
  IF (err.NE.0) STOP 'MPI_Comm_rank error' 

  emisor=0
  tag=0
  ! DIVISION DE TAREAS, según Flint, multiples tareas multiples datos
  IF (rank.EQ.emisor) THEN
  ! leer datos del archivo, si no hay archivo usar la base cero
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
     WRITE (*,*) "# Base para el hilo ",rank,": ",base
     !
     DO receptor=1,size-1,1
        CALL MPI_SEND(base+receptor, 1, MPI_INTEGER, receptor, tag, MPI_COMM_WORLD, err)
     END DO
  ELSE
     CALL MPI_RECV(base, 1, MPI_INTEGER, emisor, tag, MPI_COMM_WORLD, status, err)
     WRITE (*,*) "# Base para el hilo ",rank,": ",base
  END IF

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

  ! reservar memoria para x
  ALLOCATE(x(samples),STAT=err)
  IF (err.NE.0) STOP 'Memoria no reservada'

  ! Llenar el arreglo con números aleatorios entre 0 y 1 tomados de una
  ! función de distribución uniforme
  CALL RANDOM_NUMBER(x)

  WRITE (*,*) "Hilo", rank, "promedio", SUM(x)/REAL(samples)

  CALL MPI_FINALIZE(err) ! esto termina el entorno
  
END PROGRAM randomTESTP



