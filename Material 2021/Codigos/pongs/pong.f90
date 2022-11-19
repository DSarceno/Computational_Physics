!    2020-02-21
!    pong.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Programa que juega pong entre dos procesos paralelos, jugando rank0
!    versus rank1.  Este es un ejercicio para mostrar el uso de las rutinas de
!    openMPI para enviar y recibir sin bloqueo:
!    MPI_SEND(start, count, datatype, dest, tag, comm, err) y
!    MPI_RECV(start, count, datatype, source, tag, comm, status, err)

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: no requiere nada mas
!    mpifort -Wall -pedantic -std=f95 -c -o pong.o pong.f90
!    mpifort -o pong.x pong.o
!    mpirun -np 2 ./pong.x

!    Copyright (C) 2020
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

PROGRAM pingpong

  USE mpi ! para incluir las bibliotecas de programación en paralelo
  IMPLICIT NONE
  
  !variables para MPI
  INTEGER :: rank, size
  INTEGER(4),DIMENSION(1:MPI_STATUS_SIZE)::status

  !variables del problema
  INTEGER:: pelotita
  REAL:: posicion
  INTEGER:: contrincante
  INTEGER,PARAMETER:: MAX_REBOTES=5
  
  ! variables auxiliares
  INTEGER :: err ! para errores
  INTEGER :: i ! para un contador

  ! iniciando MPI, parar el programa si no funciona
  CALL MPI_Init(err)
  IF (err.NE.0) STOP 'MPI_Init error'

  ! ahora hay que saber con cuantos nodos vamos a trabajar y validamos que sea
  ! un numero par
  CALL MPI_Comm_size(MPI_COMM_WORLD,size,err)
  IF (err.NE.0) STOP 'MPI_Comm_size error'

  ! probar que pasa si uso esta forma de parar el programa
  ! IF (size.NE.0) STOP 'MPI_Comm_rank error'
  IF (size.EQ.2) THEN
     ! ya que vamos a separar por pares e impares, cada nodo debe saber en que
     ! equipo le toca jugar
     CALL MPI_Comm_rank(MPI_COMM_WORLD,rank,err) ! dice a cada nodo quién es
     IF (err.NE.0) STOP 'MPI_Comm_rank error' ! esto es programación defensiva

     ! iniciamos el contador de rebotes e iniciamos el ciclo
     pelotita=0
     posicion=0
     contrincante=MOD(rank+1,2)
     DO i=1,MAX_REBOTES
        IF (rank.EQ.MOD(pelotita,2)) THEN
           pelotita=pelotita+1
           posicion=posicion+REAL(MOD(i,2))
           ! MPI_SEND(start, count, datatype, dest, tag, comm, err)
           CALL MPI_SEND(pelotita, 1, MPI_INTEGER, contrincante, 0, MPI_COMM_WORLD, err)
           CALL MPI_SEND(posicion, 1, MPI_REAL, contrincante, 0, MPI_COMM_WORLD, err)
           WRITE (*,'(A,I4,A,I2,A,I4)') "Salto:",i," enviado por ",rank," a ",contrincante
        ELSE
           ! MPI_RECV(start, count, datatype, source, tag, comm, status, err)
           CALL MPI_RECV(pelotita, 1, MPI_INTEGER, contrincante, 0, MPI_COMM_WORLD, status, err)
           CALL MPI_RECV(posicion, 1, MPI_REAL, contrincante, 0, MPI_COMM_WORLD, status, err)
           WRITE (*,'(A,I4,A,I2,A,F4.1)') "Salto:",i," recibido de ",contrincante," en ",posicion
        END IF
     END DO
  ELSE
     WRITE (*,*) 'Este ping pong se juega con dos participantes'
  END IF
  CALL MPI_Finalize(err)
  
END PROGRAM pingpong
