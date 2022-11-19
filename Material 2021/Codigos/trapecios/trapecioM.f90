!    2017-08-07
!    trapecioM.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Implementación de la regla del trapecio para integración numérica con el
!    objetivo de usar módulos con funciones para calcular f(x). Ver J. Douglas
!    Faires, Richard L. Burden, "Numerical Methods" 4th, Cengage Learning,
!    2012.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: requiere types.f90 y pool.f90
!    gfortran -Wall -pedantic -std=f95 -c -o types.o types.f90
!    gfortran -Wall -pedantic -std=f95 -c -o funciones.o funciones.f90
!    gfortran -Wall -pedantic -std=f95 -c -o factorial.o factorial.f90
!    gfortran -Wall -pedantic -std=f95 -c -o besselJ.o besselJ.f90
!    gfortran -Wall -pedantic -std=f95 -c -o pool.o pool.f90
!    gfortran -Wall -pedantic -std=f95 -c -o trapecioM.o trapecioM.f90
!    gfortran -o trapecioM.x types.o pool.o funciones.o factorial.o besselJ.o trapecioM.o 

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
  ! se hace usando funciones y módulos.  Los datos para el cálculo se leen del
  ! archivo parametros.conf que tiene la configuración de ejemplo como la que
  ! está en las últimas cuatro líneas al final de este archivo.

  USE types,ONLY:FP,I4B  ! para agregar el módulo types, solamente I4B y FP
  USE pool               ! para agregar TODO el módulo pool
  IMPLICIT NONE ! esto es para que no se nos olvide declarar las variables

  ! definición de variables del problema
  REAL(FP)::a,b  ! para los límites x=a y x=b
  REAL(FP)::x    ! para evaluar la función f(x)
  REAL(FP)::h    ! para el tamaño de los intervalos
  REAL(FP)::S    ! para guardar el área bajo la curva
  INTEGER(I4B)::m ! para el órden de la función de Bessel J
  INTEGER(I4B)::n ! para el número de intervalos

  ! definición de variables auxiliares
  INTEGER(I4B)::i   ! para contador en ciclos
  INTEGER(I4B)::err ! para guardar códigos de error

  ! es una buena práctica de programación decir qué está haciendo el código y
  ! el símbolo de numeral se suele entender como comentario por muchos de los
  ! programas de análisis que se usarán
  WRITE (*,*) "# Integración por el método de trapecios"
  WRITE (*,*) "# Número de trapecios, Área bajo la curva"
  
  ! asignar a la unidad 12 un archivo de lectura, guardar el código de error
  OPEN(12,FILE="parametros.conf",STATUS="OLD",IOSTAT=err)
  IF (err.NE.0) STOP 'Archivo parametros no se ha encontrado'
  ! aquí hay una lista de los códigos de error para IOSTAT
  ! http://msg.ucsf.edu/local/programs/IBM_Compilers/Fortran/html/pgs/lr76.htm
  
  ! lectura de datos
  READ(12,*) ! esto es para quitar la línea del encabezado
  READ(12,*) a ! leer el límite a
  READ(12,*) b ! leer el límite b
  READ(12,*) n ! leer el número de intervalos
  READ(12,*) m ! leer el órden de la función de Bessel J

  CLOSE(12) ! siempre hay que cerrar los archivos

  ! cálculos iniciales de h y de la función en los extremos del intervalo
  h=(b-a)/REAL(n) 
  S=J(m,a)+J(m,b)

  ! ciclo principal del programa
  DO i=1,n-1,1
     x=a+h*REAL(i)
     S=S+2.*J(m,x)
  END DO

  ! cálculos finales
  S=S*h/2.

  WRITE (*,*) n,S

END PROGRAM trapecio

! ejemplo de parametros.conf
! 0  ! para a
! 1  ! para b
! 4  ! para n
! 0  ! para m
