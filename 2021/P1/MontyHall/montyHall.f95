!    2021-01-28
!    montyHall.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa <program>

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o montyHall.o montyHall.f95
!    gfortran -o montyHall.x montyHall.o

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

PROGRAM montyHall
  IMPLICIT NONE

  ! VARIABLES
  ! Showman variables
  REAL :: good_door    ! random number to generate de position of the good door
  INTEGER :: pos_good_door   ! number n in [1,3] where is the price
  INTEGER, DIMENSION(3) :: doors    ! The three doors of the Classic MH problem

  ! Contestant variables
  REAL :: choice
  INTEGER :: pos_choice
  INTEGER :: success_s, n   ! counter of success and number of iterations

  INTEGER :: success_c      !

  INTEGER :: n_d      ! Number of data

  INTEGER :: i,j    ! Iterator

  INTEGER(4) :: err


  ! Arrays fo data analysis
  INTEGER :: sum
  INTEGER,ALLOCATABLE,DIMENSION(:) :: data

  ! ALGORITHM
  doors = 0     ! Vector 0
  CALL RANDOM_NUMBER(good_door)
  pos_good_door = 1 + FLOOR(3*good_door)  ! Random position of the price

  doors(pos_good_door) = 1     ! asignar la puerta del exito en el vector

  WRITE(*,*) doors


  n_d = 100     ! numero de datos a reopilar

  ! STAY DECISION



  n = 10000     ! Iterations
  DO i = 1, n_d
    success_s = 0   ! initializing the counter of success
    DO j = 1, n
      CALL RANDOM_NUMBER(choice)
      pos_choice = 1 + FLOOR(3*choice)  ! Random position of the price

      IF (doors(pos_choice) .EQ. 1) THEN
        success_s = success_s + 1
      END IF
    END DO

    WRITE(1,*) success_s
  END DO
  CLOSE(1)


  ! CHANGE DECISION

  n = 10000     ! Iterations
  DO i = 1, n_d
    success_c = 0   ! initializing the counter of success
    DO j = 1, n
      CALL RANDOM_NUMBER(choice)
      pos_choice = 1 + FLOOR(3*choice)  ! Random position of the price

      IF (doors(pos_choice) .EQ. 0) THEN
        success_c = success_c + 1
      END IF
    END DO

    WRITE(2,*) success_c
  END DO
  CLOSE(2)

  ! Data analysis
  ALLOCATE(data(n_d),STAT=err)
  IF (err.NE.0) STOP "Memoria no reservada"
  OPEN(12,FILE="fort.1",IOSTAT=err)
  IF (err.EQ.0) THEN
    DO j = 1,n_d
      READ(12,*) data(j)
    END DO
  ELSE
    STOP "Archivo no encontrado"
  END IF
  CLOSE(12)

  WRITE(*,*) data

  sum = 0
  DO j=1,n_d
    sum = sum + data(j)
  END DO

  WRITE(*,*) "Sin cambiar su desición inicial: ", ((REAL(sum)/REAL(n_d))/REAL(n))*100, "%"
  

  DEALLOCATE(data)
END PROGRAM montyHall

































! END
