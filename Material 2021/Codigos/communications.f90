!    2017-8-22
!    communications.f90
!    Giovanni Ramirez (ramirez@ecfm.usac.edu.gt)

!    Prueba de las subrutinas de comunicaciones

!    Codificación: UTF-8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere mpi
!    mpifort -Wall -pedantic -std=f95 -c -o communications.o communications.f90
!    mpifort -o communications.x communications.o

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
PROGRAM communications

  USE mpi
  IMPLICIT NONE

  ! definir variables mpi
  INTEGER(4):: size ! cuantos hilos
  INTEGER(4):: rank ! quién es cada uno

  ! definir variables control
  INTEGER(4):: err

  ! iniciar entorno mpi
  CALL MPI_Init(err) ! esto inicia el entorno
  IF (err.NE.0) STOP 'MPI_Init error'

  ! saber cuantos nodos hay
  CALL MPI_Comm_size(MPI_COMM_WORLD,size,err) ! dice cuántos nodos hay
  IF (err.NE.0) STOP 'MPI_Comm_size error' ! esto es programación defensiv

  ! saber el número de cada nodo
  CALL MPI_Comm_rank(MPI_COMM_WORLD,rank,err) ! dice a cada nodo quién es
  IF (err.NE.0) STOP 'MPI_Comm_rank error' ! esto es programación defensiv

  CALL hello

  CALL hello2(rank,size)

  CALL hello3(rank,size)

  CALL hello4(rank,size)

  ! terminar entorno mpi
  CALL MPI_FINALIZE(err) ! esto termina el entorno
  IF (err.NE.0) STOP 'MPI_Init error' 

CONTAINS
  ! Todos los procesos hacen exactamente la misma tarea.  Cada procesador
  ! imprime una línea.  Las subrutinas MPI_Init y MPI_Finalize se encargan de
  ! los detalles del entorno de ejecución en múltiples procesadores.  Siempre
  ! debe llamarse a MPI_Init antes de cualquier otra instrucción MPI. La
  ! subrutina MPI_Finalize debe ir al final.
  SUBROUTINE hello
    WRITE (*,'(A)',ADVANCE='NO') "HELLO 1: "
    WRITE (*,*) "hola mundo!"
    RETURN
  END SUBROUTINE hello

  ! En este caso, cada proceso conoce cuántos procesos hay en total en el
  ! grupo y quién es ese proceso en el grupo.  La asignación del nombre o
  ! rango en el grupo se hace a un número entero.
  SUBROUTINE hello2(r,s)
    INTEGER(4),INTENT(IN)::r ! para rank
    INTEGER(4),INTENT(IN)::s ! para size
    WRITE (*,'(A)',ADVANCE='NO') "HELLO 2: "
    WRITE (*,*) "hola mundo! soy ",r," de ",s
    RETURN
  END SUBROUTINE hello2

  ! Ya que cada proceso conoce su rango y que éste no se repite, entonces
  ! somos capaces de asignar tareas a cada uno de los procesos.
  SUBROUTINE hello3(r,s)
    INTEGER(4),INTENT(IN)::r ! para rank
    INTEGER(4),INTENT(IN)::s ! para size
    
    IF (r.NE.0) THEN
       WRITE (*,'(A)',ADVANCE='NO') "HELLO 3: "
       WRITE (*,*) "hola mundo! soy ",r," de ",s
    ELSE
       WRITE (*,'(A)',ADVANCE='NO') "HELLO 3: "
       WRITE (*,*) "hola mundo! y yo soy",r, " de ",s
    END IF
    RETURN
  END SUBROUTINE hello3

  ! Ahora vamos a enviar variables que pueden ser de estos tipos
  
  ! MPI_CHAR: This is the traditional ASCII character that is numbered by
  ! integers between 0 and 127.

  ! MPI_UNSIGNED_CHAR: This is the extended character numbered by integers
  ! between 0 and 255.

  ! MPI_BYTE: This is an 8-bit positive integer betwee 0 and 255, i.e., a
  ! byte.

  ! MPI_WCHAR_T: This is a wide character, e.g., a 16-bit character such as a
  ! Chinese ideogram.

  ! MPI_SHORT: This is a 16-bit integer between -32,768 and 32,767. 

  ! MPI_UNSIGNED_SHORT: This is a 16-bit positive integer between 0 and
  ! 65,535.

  ! MPI_INT: This is a 32-bit integer between -2,147,483,648 and
  ! 2,147,483,647.

  ! MPI_UNSIGNED: This is a 32-bit unsigned integer, i.e., a number between 0
  ! and 4,294,967,295.

  ! MPI_LONG: This is the same as MPI_INT on IA32.

  ! MPI_UNSIGNED_LONG:  This is the same as MPI_UNSIGNED on IA32. 

  ! MPI_FLOAT: This is a single precision, 32-bit long floating point number. 

  ! MPI_DOUBLE: This is a double precision, 64-bit long floating point number.

  ! MPI_LONG_DOUBLE: This is a quadruple precision, 128-bit long floating
  ! point number.

  ! MPI_LONG_LONG_INT: This is a 64-bit long signed integer, i.e., an integer
  ! number between -9,223,372,036,854,775,808 and 9,223,372,036,854,775,807
  ! (this reads: 9 quintillions 223 quadrillions 372 trillions 36 billions 854
  ! millions 775 thousand 8 hundred and seven - not a large sum of money by
  ! Microsoft standards).

  ! MPI_LONG_LONG: Same as MPI_LONG_LONG_INT.

  ! MPI_FLOAT_INT: This is a pair of a 32-bit floating point number followed
  ! by a 32-bit integer.

  ! MPI_DOUBLE_INT: This is a pair of a 64-bit floating point number followed
  ! by a 32-bit integer.

  ! MPI_LONG_INT: This is a pair of a long integer (which under IA32 is just a
  ! 32-bit integer) followed by a 32-bit integer.

  ! MPI_SHORT_INT: This is a pair of a 16-bit short integer followed by a
  ! 32-bit integer.

  ! MPI_2INT: This is a pair of two 32-bit integers.

  ! MPI_LONG_DOUBLE_INT: This is a pair of a quadruple precision 128-bit long
  ! floating point number and a 32-bit integer.

  ! MPI_LB: The lower bound marker.

  ! MPI_UB: The upper bound marker.

  SUBROUTINE hello4(r,s)
    INTEGER(4),INTENT(IN)::r ! para rank
    INTEGER(4),INTENT(IN)::s ! para size

    ! variables para el mensaje por mpi
    INTEGER(4):: mensaje
    INTEGER(4)::err
    INTEGER(4),DIMENSION(1:MPI_STATUS_SIZE)::status
    INTEGER(4)::master,tag
    ! variables extra
    INTEGER(4):: emisor ! para contar

    master=0
    tag=0

    IF (r.EQ.master) THEN
       WRITE (*,'(A)',ADVANCE='NO') "HELLO 4"
       WRITE (*,*) "hola mundo! soy ",r," de ",s
       DO emisor=1,s-1,1
          CALL MPI_RECV(mensaje,1,MPI_INTEGER,emisor,1,MPI_COMM_WORLD,status, err)
          WRITE (*,'(A)',ADVANCE='NO') "HELLO 4"
          WRITE (*,*) "mensaje de ",emisor,mensaje
       END DO
    ELSE
       mensaje=rank
       CALL MPI_SEND(mensaje, 1, MPI_INTEGER, 0, 1, MPI_COMM_WORLD, err)
    END IF
    RETURN
  END SUBROUTINE hello4


END PROGRAM communications
