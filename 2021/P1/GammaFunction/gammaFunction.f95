!    2021-05-17
!    gammaFunction.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa <program>

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o gammaFunction.o gammaFunction.f95
!    gfortran -o gammaFunction.x gammaFunction.o

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
PROGRAM gammaFunction
IMPLICIT NONE
  REAL(16) :: z
  INTEGER(16) :: n
  INTEGER(4) :: err
  REAL(16) :: gammaF, g


  OPEN(12,FILE = 'zn.in', STATUS = 'OLD', IOSTAT = err)
  IF (err.EQ.0) THEN
    READ(12,*) n
    READ(12,*) z
    CLOSE(12)
  ELSE
    WRITE(*,*) 'No se encontró el archivo'
  END IF

   g = gammaF(z,n)
   WRITE(*,*) g

END PROGRAM gammaFunction


FUNCTION gammaF(z,n) RESULT(gamma)
IMPLICIT NONE
  INTEGER(16), INTENT(IN) :: n
  REAL(16), INTENT(IN) :: z
  REAL(16) :: gamma
  REAL(16) :: zn
  INTEGER(16) :: factorial
  ! iteradores
  INTEGER(16) :: i

  zn = 1
  DO i = 0, n
    zn = zn*(z + i)
  END DO

  gamma = (factorial(n) / zn) * (n**z)

END FUNCTION gammaF

RECURSIVE FUNCTION factorial(n) RESULT(fact)
IMPLICIT NONE
  INTEGER(16), INTENT( IN) :: n
  INTEGER(16) :: fact
  fact = 1
  IF (n.EQ.0) THEN
    fact = 1
  ELSE
    fact = n*factorial(n - 1)
  END IF

END FUNCTION factorial














! END
