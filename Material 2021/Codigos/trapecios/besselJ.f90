!    2017-08-08
!    besselJ.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementación de las funciones de Bessel J

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere types.f90 y factorial
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o factorial.o factorial.f90
!    gfortran -Wall -pedantic -std=f95 -c -o besselJ.o besselJ.f90

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


! función de Bessel, forzando a que el orden n sea entero
! ENTRADA: un valor real y uno entero para calcular la función de Bessel de
! orden entero
! SALIDA: un valor real con el valor de la función de Bessel
FUNCTION J(n,x)
  USE types,ONLY:FP,I4B
  IMPLICIT NONE
  
  ! necesitamos decirle a esta función que puede usar la que hemos definido
  ! antes para este mismo módulo, vamos a usar la función recursiva que suele
  ! ser más ligera, sino habría que hacer una interfaz para la subrutina
  ! iterativa.  Para no hacer esto, también se puede hacer otro módulo,
  ! entonces se podrían guardar allí todas las funciones auxiliares
  INTERFACE
     RECURSIVE FUNCTION FactorialR(n)  RESULT(Fact)
       USE TYPES,ONLY:I4B
       IMPLICIT NONE
       INTEGER(I4B), INTENT(IN) :: n 
       INTEGER(I4B) :: Fact 
     END FUNCTION FactorialR
  END INTERFACE

  ! variables del problema
  INTEGER(I4B),INTENT(IN)::n  ! para el orden de la función de Bessel
  REAL(FP),INTENT(IN)::x ! para la evaluación de la función de Bessel
  REAL(FP)::J  ! nombre de la función para devolver el resultado

  ! variables auxiliares
  INTEGER(I4B)::numeroTerminos ! cuántos términos incluir
  INTEGER(I4B)::m ! para los elementos de la suma
  REAL(FP)::mReal,nReal ! para hacer el casting una vez
  INTEGER(I4B)::err ! para los códigos de error

  ! inicialización de variables
  J=0.
  numeroTerminos=3
  nReal=REAL(n)

  ! asignar a la unidad 13 un archivo de lectura, dejar 3 en caso de error
  OPEN(13,FILE="terms.conf",STATUS="OLD",IOSTAT=err)
  IF (err.EQ.0) THEN
     ! lectura de datos
     READ(13,*) ! esto es para quitar la línea del encabezado
     READ(13,*) numeroTerminos ! leer el número de términos deseado
     CLOSE(13)
  END IF

  ! ciclo principal
  DO m=0,numeroTerminos
     mreal=REAL(m)
     J=J+(-1.)**mReal*(x/2.)**(2.*mReal+nReal)&
          /REAL(FactorialR(m)*FactorialR(m+n+1))
  END DO

  WRITE (*,*) "# Funcion de Bessel",J
  RETURN 
END FUNCTION J


