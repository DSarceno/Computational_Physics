!    2021-05-17
!    gammaFunctionWF.f95
!    Diego Sarceño (dsarceno68@gmail.com)

!    Programa <program>

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.3.0
!    Instrucciones de compilación: no requere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o gammaFunctionWF.o gammaFunctionWF.f95
!    gfortran -o gammaFunctionWF.x gammaFunctionWF.o

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
  INTEGER(16) :: n, fact, i
  INTEGER(4) :: err
  REAL(16) :: gamma
  REAL(16) :: zn


  OPEN(12,FILE = 'zn.in', STATUS = 'OLD', IOSTAT = err)
  IF (err.EQ.0) THEN
    READ(12,*) n
    READ(12,*) z
    CLOSE(12)
  ELSE
    WRITE(*,*) 'No se encontró el archivo'
  END IF



   zn = 1
   DO i = 0, n
     zn = zn*(z + i)
   END DO

   fact = 1
   IF (n.EQ.0) THEN
     fact = 1
   ELSE
     DO i = 1, n
       fact = fact*i
     END DO
   END IF

   gamma = (fact / zn) * (n**z)
   WRITE(*,*) gamma


END PROGRAM gammaFunction













! END
