!    2021-02-12
!    sesion02.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Este es un programa paso a paso con pruebas de variables

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.5.0
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o Sesion02.o Sesion02.f90
!    gfortran -o Sesion02.x Sesion02.o 

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


PROGRAM Sesion02

  IMPLICIT NONE

  ! las variables logicas pueden tener valores .FALSE. y .TRUE.
  LOGICAL:: verdadero

  ! variables CHAR
  CHARACTER:: nombre ! 8-bit ASCII/ISO
  
  ! las variables enteras  
  INTEGER(1):: a ! 8-bit signed integers, [-128,127]
  INTEGER(2):: b ! 16-bit signed integer, [-32768,32767]
  INTEGER(4):: c ! 32-bit signed integer, [-2,147,483,648, 2,147,483,647]
  INTEGER(8):: d ! 64-bit signed integer, [-9.22E18, 9.22E18]

  ! las variables reales
  ! single precision, 32-bit floating point, +/-(1.1754E-38, 3.4028E38)
  REAL(4):: x ! precisión de 24 bits: 6 o 7 dígitos decimales
  ! double precision, 64-bit floating point, +/-(2.2250D-308, 1.7976D308)
  REAL(8):: y ! precisión de 52 bits: 15 o 16 dígitos decimales
  ! quad precision, 128-bit floating point, INVESTIGAR EL RANGO
  REAL(16):: z

  ! variables complejas
  COMPLEX(4):: w1 ! dos variables REAL(4)
  COMPLEX(8):: w2 ! dos variables REAL(8)
  COMPLEX(16):: w3 ! dos variables REAL(16)

  ! constantes
  REAL(8),PARAMETER:: PI=3.1415926535897932d0
  REAL(4),PARAMETER:: OT=3.2e1
  INTEGER(4),PARAMETER:: PRIMOPAR=2
  



  ! Uso de variables char
  nombre='q'
  WRITE (*,*) nombre
  
  ! Uso de variables lógicas
  verdadero=.FALSE.
  ! las variables lógicas se pueden usar directamente en pruebas de
  ! condicionales
  WRITE (*,*) verdadero
  IF (verdadero) THEN
     WRITE (*,*) "Se hace esto si la prueba es verdadera"
  ELSE
     WRITE (*,*) "o esto si la prueba es falsa"
  END IF

  ! Las operaciones lógicas que se pueden hacer entre variables lógicas son
  ! .NOT.
  ! .AND.
  ! .OR.
  ! .EQV.
  ! .NEQV.

  ! las variables enteras se pueden usar para todas las operaciones
  ! aritméticas y algebráicas.
  WRITE (*,*) a
  WRITE (*,*) b
  WRITE (*,*) c
  WRITE (*,*) d
  WRITE (*,*)
  
  ! las variables reales se pueden usar para todas las operaciones
  ! aritméticas y algebráicas.
  WRITE (*,*) x
  WRITE (*,*) y
  WRITE (*,*) z
  WRITE (*,*) w1
  WRITE (*,*) w2
  WRITE (*,*) w3
  WRITE (*,*)


  ! operadores y su precedencia
  ! () agrupación por paréntesis
  ! ** potencia
  ! - operador de negación
  ! * multiplicación
  ! / división: poner atención a la división entre enteros y entre reales
  ! + suma
  ! - resta

  ! casting: conversión de tipos numéricos

  ! int(A): Truncated integer, returns integer
  ! int2(A): Truncated 16-bit integer, returns integer(2)
  ! int8(A): Truncated 64-bit integer, returns integer(8)
  ! nint(A): Nearest integer, returns integer
  ! anint(A): Nearest whole real/double, returns same as A
  ! real(A): Nearest real, returns real
  ! dble(A): Nearest double precision, returns double precision
  ! cmplx(R [,I]): Nearest complex, returns complex
  ! dcmplx(R [,I]): Nearest double complex, returns double complex

  
END PROGRAM Sesion02

  
