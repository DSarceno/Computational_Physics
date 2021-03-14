!    2021-01-28
!    decision.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o decision.o decision.f95

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

MODULE functions

PUBLIC stay, change

CONTAINS
  FUNCTION stay (doors) RESULT(success_s)
    IMPLICIT NONE

    INTEGER, INTENT(IN) :: doors

    ! Contestant variables
    REAL :: choice
    INTEGER :: pos_choice
    INTEGER :: success_s, n   ! counter of success and number of iterations

    INTEGER :: i    ! Iterator

    ! Contestant random choice
    CALL RANDOM_NUMBER(choice)
    pos_choice = 1 + FLOOR(3*choice)  ! Random position of the price

    success_s = 0   ! initializing the counter of success
    n = 100     ! Iterations
    DO i = 1, n
      IF (doors(pos_choice) .EQ. 1) THEN
        success_s = success_s + 1
      END IF
    END DO



  END FUNCTION stay


  FUNCTION change (doors) RESULT(success_c)
    IMPLICIT NONE

    ! New showman variables
    INTEGER, DIMENSION(2) :: new_doors
    INTEGER :: success_c
    success_c = 0

    ! Contestant variables
    INTEGER, INTENT(IN) :: doors
    REAL :: choice
    INTEGER :: pos_choice

    ! Contestant random choice
    CALL RANDOM_NUMBER(choice)
    pos_choice = 1 + FLOOR(3*choice)  ! Random position of the price



  END FUNCTION change

END MODULE functions
















































! END
