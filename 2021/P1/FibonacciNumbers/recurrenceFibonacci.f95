!    2021-01-30
!    recurrenceFibonacci.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa <program>

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o recurrenceFibonacci.o recurrenceFibonacci.f95
!    gfortran -o recurrenceFibonacci.x recurrenceFibonacci.o

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
PROGRAM recurrenceFibonacci
  IMPLICIT NONE
  ! numero ingresado
  INTEGER(16) :: n
  ! Paso
  INTEGER(16) :: a,b,step
  ! variable de error
  INTEGER :: err
  ! iteradores
  INTEGER(16) :: i

  OPEN(12,FILE = 'n.in', STATUS = 'OLD', IOSTAT = err)
  IF (err.EQ.0) THEN
    READ(12,*) n
    CLOSE(12)
  ELSE
    WRITE(*,*) 'No se encontró el archivo'
  END IF

  ! Recurrencia de fibonacci con los casos iniciales separados
  IF (n.EQ.1) THEN
    b = 1
  ELSE IF (n.EQ.2) THEN
    b = 1
  ELSE
    ! Estados iniciales de la recurrencia
    a = 0
    b = 1
    ! Recurrencia de fibonacci
    DO i = 1,n
      step = a + b ! paso de la recurrencia
      a = b
      b = step
    END DO
    WRITE(*,*) a ! n-esimo término
  END IF
END PROGRAM recurrenceFibonacci


































! END
