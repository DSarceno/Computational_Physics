!    2021-02-09
!    sesion01.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Este es un programa paso a paso con pruebas de entrada y salida desde las
!    interfases estándar y desde archivos.

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.5.0
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o Sesion01.o Sesion01.f90
!    gfortran -o Sesion01.x Sesion01.o 

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



!!! INICIO DEL PROGRAMA

!! esta instrucción dice al compilador que aquí inicia el programa
PROGRAM Sesion01


!!! VARIABLES
  
  !! esta instrucción es importante para definir nosotros las variables
  IMPLICIT NONE
  
  !! variables del problema para hacer operaciones con números reales y enteros
  !! aquí vamos a definir variables enteras
  INTEGER(4):: a,b
  INTEGER(8):: c,d
  !! aquí vamos a definir variables reales
  REAL(4):: x,y
  REAL(8):: r,t

  !! además de las variables de control, muchas veces se necesitan algunas
  !! variables de control para manejo de errores, el estatus de algunas
  !! funciones, etc.
  !! variables de control
  INTEGER(4):: err




!!! SALIDA A TERMINAL Y A ARCHIVOS
  
  !! En fortran la entrada y salida de información se entiende de la misma
  !! forma que en linux.  La información es un flujo que puede ser redirigido
  !! para "volcar" la información a la pantalla o a un archivo; así también se
  !! puede redirigir la información de entrada del teclado o desde algún
  !! archivo.

  !! Salida a terminal.  El uso de la instrucción print viene desde fortran 77
  !! y tiene menos opciones que la instrucción write.  La instrucción print
  !! suele enviar la la información a la salida estándar del sistema y esto
  !! puede ser la pantalla o una impresora, así que cada vez es menos
  !! recomendable.  Con la instrucción write uno puede elegir la salida a la
  !! pantalla o a algún archivo.
  WRITE (*,*) "Hola mundo!"

  ! los argumentos entre paréntesis en la función WRITE son, el primero para
  ! la unidad donde se quiere escribir y el segundo para el formato de cómo se
  ! quiere escribir la salida que vamos a explorar cuando ya vayamos a
  ! imprimir números.

  ! en este caso, vamos a escribir en la unidad 99, cada unidad va a escribir
  ! un archivo que se va a llamar fort con un punto y el número de la unidad.
  ! Esta escribe en el archivo fort.99
  WRITE (99,*) "Hola mundo!"


 

  !!! ENTRADA DESDE TERMINAL Y DESDE ARCHIVOS

  ! en general, la función READ sirve para la para la entrada de información
  ! desde terminal o desde archivos, tiene dos argumentos al igual que la
  ! anterior y le sirven para saber desde qué unidad se va leer y con qué
  ! formato. Se puede poner una instrucción para cada variable o separadas por
  ! comas
  WRITE (*,'(A)',ADVANCE='NO') "Ingrese cuatro números enteros: "
  READ(*,*) a,b
  READ(*,*) c,d

  WRITE (*,*) a,b,c,d
  WRITE (99,*) a,b,c,d

  ! los archivos también son una unidad que debe declararse adecuadamente
  ! según se quiera leer o escribir, siempre con atención ya que los archivos
  ! para escritura se pueden borrar antes y después escribir o solamente
  ! añadir la información al final del archivo.  Se usa la función OPEN y yo
  ! suelo aprovechar la variable IOSTAT para saber si el archivo se abrió
  ! adecuadamente.

  ! abrir el archivo param.conf en modo lectura y asociarlo a la unidad 12, si
  ! el archivo no existe o no se tienen permisos de lectura, la variable err
  ! va a regresar con un valor TRUE o 1 y eso nos sirve para parar la
  ! ejecución del programa.
  OPEN(UNIT=12,FILE="parametros",STATUS="OLD",IOSTAT=err)

  ! la función IF funciona de la misma forma en todos los lenguajes de
  ! programación, si la operación lógica que está entre paréntesis es verdera
  ! entonces se ejecuta una instrucción
  IF (err.NE.0) STOP 'no se ha encontrado el archivo parametros' 

  ! lectura de los datos de la unidad 12
  READ(12,*) a
  READ(12,*) b
  READ(12,*) c
  READ(12,*) d
  READ(12,*) x
  READ(12,*) y
  READ(12,*) r
  READ(12,*) t
  

  ! siempre hay que cerrar los archivos, principalmente cuando estamos
  ! escribiendo nuestros resultados
  CLOSE(12)


!!! FORMATO ver las notas abajo
  
  ! vamos a imprimir los números sin formato y con formato
  WRITE (*,*) "sin formato"
  WRITE (*,*) a,b,c,d
  WRITE (*,*) x,y,r,t

  WRITE (*,*) "con formato"
  WRITE (*,'(2I4)') a,b
  WRITE (*,'(2I6)') c,d
  WRITE (*,'(2F7.4)') x,y
  WRITE (*,'(2E16.6)') r,t


END PROGRAM Sesion01
! ejemplo del archivo parametros

! Descriptores de formato (original de
! https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/chap05/format.html )

! 1. Cada descriptor le dice al sistema cómo manejar cada tipo.  Cada valor
!    requiere un número de posiciones adecuado.  Por ejemplo, un entero de
!    cuatro dígitos requiere por lo menos cuatro escpacios o posiciones dígitos
!    para imprimirse.

! 2. Se deben usar estas convenciones 
!     w: el número de posiciones que se usarán
!     m: el número mínimo de posiciones que se usarán 
!     d: el número de dígitos a la derecha del punto decimal
!     e: el número de dígitos en la parte exponencial



! 3. Importante, el número de posiciones no representa la precisión del número
!     (los números significativos).

! 4. Descriptores

! 4.1 Lectura y escritura de enteros Iw, Iw.m
! 4.2 Lectura y escrutura de reales
!     Forma decimal Fw.d
!     Forma exponencial Ew.d, Ew.dEe
!     Forma científica  ESw.d ESw.dEe
!     Forma ingeniería  ENw.d ENw.dEe
! 4.3 Lectura y escritura de variables lógicas Lw
! 4.4 Posicionamiento
!     Horizontal nX
!     Tabulador  Tc TLc, TRc
!     Vertical /
! 4.5 Otros
!     Agrupar r(···)
!     Format scanning control :
!     Sign control S, SP, SS
!     Blank control BN y BZ
