!    2017-08-02
!    types.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementación de un módulo para la definición más sencilla de los tipos

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: no requiere nada
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90

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

MODULE types

  ! integer types
  INTEGER,PARAMETER:: I4B =SELECTED_INT_KIND(9)
  INTEGER,PARAMETER:: I2B =SELECTED_INT_KIND(4)
  INTEGER,PARAMETER:: I1B =SELECTED_INT_KIND(2)

  ! real precision select only one
  INTEGER,PARAMETER:: FP =KIND(1.0)   ! single precision
  ! INTEGER,PARAMETER:: FP =KIND(1.0D0) ! double precision

END MODULE types
