!    2017-08-07
!    trapecioF.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementación de la regla del trapecio para integración numérica con el
!    objetivo de usar funciones para calcular f(x). Ver J. Douglas Faires,
!    Richard L. Burden, "Numerical Methods" 4th, Cengage Learning, 2012.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5 y 7.3.1
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o trapecioF.o trapecioF.f90
!    gfortran -o trapecioF.x trapecioF.o 

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

PROGRAM trapecio
  ! Este programa implementa la regla del trapecio con intervalos uniformes
  ! que calcula el área limitada por y=0, x=a, x=b y f(x). La implementación
  ! se hace usando funciones.  Los datos para el cálculo se leen del archivo
  ! parametros.conf que tiene la configuración de ejemplo como la que está en
  ! las últimas cuatro líneas al final de este archivo.

  IMPLICIT NONE ! esto es para que no se nos olvide declarar las variables

  ! definición de variables del problema
  REAL(4)::a,b  ! para los límites x=a y x=b
  REAL(4)::x    ! para evaluar la función f(x)
  REAL(4)::h    ! para el tamaño de los intervalos
  REAL(4)::Area ! para guardar el área bajo la curva
  INTEGER(4)::n ! para el número de intervalos

  ! definición de variables auxiliares
  INTEGER(4)::i   ! para contadores
  INTEGER(4)::err ! para guardar códigos de error

  ! es una buena práctica de programación decir qué está haciendo el código y
  ! el símbolo de numeral se suele entender como comentario por muchos de los
  ! programas de análisis que se usarán
  WRITE (*,*) "# Integración por el método de trapecios"
  WRITE (*,*) "# Número de trapecios, Área bajo la curva"

  ! asignar a la unidad 12 un archivo de lectura, guardar el código de error
  OPEN(12,FILE="parametros.conf",STATUS="OLD",IOSTAT=err)
  IF (err.NE.0) STOP 'Archivo parametros no se ha encontrado'

  ! lectura de datos
  READ(12,*) ! esto es para quitar la línea del encabezado
  READ(12,*) a ! leer el límite a
  READ(12,*) b ! leer el límite b
  READ(12,*) n ! leer el número de trapecios

  CLOSE(12) ! siempre hay que cerrar los archivos

  ! no quiero hacer una división entre cero... TAREA: probar qué resultado
  ! sale
  IF (n.LT.1) STOP 'Debe usar mas trapecios'
  !cálculos iniciales de h y de la función en los extremos del intervalo
  h=(b-a)/REAL(n)
  Area=f(a)+f(b)

  ! ciclo principal del programa
  DO i=1,n-1,1
     x=a+h*REAL(i)
     Area=Area+2.*f(x)
  END DO

  ! cálculos finales
  Area=Area*h/2.

  WRITE (*,*) n, Area


CONTAINS
  FUNCTION f(x)
    REAL(4),INTENT(IN)::x  ! variable para la evaluación de la función
    REAL(4)::f  ! nombre de la función para devolver el resultado

    ! Hay que dejar sin comentar una de las funciones que están aquí
    ! funciones de prueba: f(x)=1, f(x)=x
    !f=1 ! a=0, b=1, n=4, S=1, ignorar la advertencia de que no se usa la
        ! variable x
    !f=x ! a=0, b=1, n=4, S=0.5

    ! función de prueba y=f(x)=4x^2+1. La traducción de estas fórmulas a
    ! código de fortran es una de las grandes ventajas de Fortran
    f=4*x**2+1

    ! Comentar y descomentar las líneas del código para ir haciendo pruebas no
    ! está del todo mal, pero es mejor aprovechar las ventajas de la
    ! modularidad.  Ver la versión modular de este código.
    RETURN 
  END FUNCTION f
END PROGRAM trapecio

! ejemplo de parametros
! 0  ! para a
! 1  ! para b
! 4  ! para n
