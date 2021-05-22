!    2021-05-18
!    armstrongNumbers.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa <program>

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o armstrongNumbers.o armstrongNumbers.f95
!    gfortran -o armstrongNumbers.x armstrongNumbers.o

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
PROGRAM armstrongNumbers
IMPLICIT NONE
  INTEGER(16) :: F, n, b, F_v
  INTEGER(16) :: i
  INTEGER :: err

  OPEN(12,FILE = 'nb.in', STATUS = 'OLD', IOSTAT = err)
  IF (err.EQ.0) THEN
    READ(12,*) b
    READ(12,*) n
    CLOSE(12)
  ELSE
    WRITE(*,*) 'No se encontró el archivo'
  END IF

  DO i = 1, n
    F_v = F(i, b)
    IF (F_v.EQ.i) THEN
      WRITE(99,*) F_v, i
    END IF
  END DO

END PROGRAM armstrongNumbers


FUNCTION F(n, b) RESULT(F_b)
  INTEGER(16), INTENT(IN) :: n, b
  INTEGER(16) :: F_b
  INTEGER(16) :: d_i, k
  INTEGER(16) :: i

  k = FLOOR(LOG(REAL(n))/LOG(REAL(b))) + 1
  !WRITE(*,*) k

  F_b = 0
  DO i = 0, k - 1
    d_i = ( MOD(n,b**(i + 1)) - MOD(n,b**i))/(b**i)
    F_b = F_b + d_i**k
  END DO

END FUNCTION F












! END
