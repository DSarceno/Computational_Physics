!    2017-08-08
!    holaMundo.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Programa hola mundo

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 4.8.5
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o holaMundo.o holaMundo.f90
!    gfortran -o holaMundo.x holaMundo.o 

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

! Fortran no distingue mayúsculas ni en las palabras reservadas ni en los
! nombres de las variables.  Lo que yo hago es mantener en mayúsculas las
! palabras reservadas de Fortran, en minúsculas los nombres de las variables y
! con letra inicial mayúscula los nombres de funciones o subrutinas, eso es lo
! que a mí me gusta y cada uno de ustedes que haga como le plazca, pero que lo
! haga así siempre.  Los programas deben llevar comentarios siempre, pero los
! comentarios no se ponen al final, después de haber terminado el programa. Los
! comentarios se deben ir poniendo cuando uno diseña el programa para tener
! clara la idea en todo momento.

! todos los programas deben iniciar con la palabra PROGRAM y el nombre del
! programa.
PROGRAM hola

  ! ! DEFINICION DE VARIABLES

  ! como les había dicho, ya no es recomendado usar la asignación implícita de
  ! las variables del programa, por lo que esta instrucción hay que ponerla
  ! siempre para obligarse a uno mismo a definir las variables
  IMPLICIT NONE

  ! cuando estamos resolviendo un problema, es bastante útil separar las
  ! variables relacionadas al problema de las variables que son de control o
  ! auxiliares

  ! variables del problema
  INTEGER(4):: a
  REAL(4):: x
  REAL(8):: y

  ! variables de control
  INTEGER(4):: err


  ! ! SALIDA A TERMINAL Y A ARCHIVOS

  ! una costumbre bastante útil es la de que el programa les diga qué es o qué
  ! hace, esta instrucción escribe en la terminal
  WRITE (*,*) "Hola mundo!"
  ! los argumentos entre paréntesis en la función WRITE son, el primero para
  ! la unidad donde se quiere escribir y el segundo para el formato de cómo se
  ! quiere escribir la salida.

  ! en este caso, estamos escribiendo en la unidad 99, cada unidad va a
  ! escribir un archivo que se va a llamar fort con un punto y el número de la
  ! unidad.  Esta escribe en el archivo fort.99
  WRITE (99,*) "Hola mundo!"


  ! ! ENTRADA DESDE TERMINAL Y DESDE ARCHIVOS

  ! en general, la función READ sirve para la para la entrada de información
  ! desde terminal o desde archivos, tiene dos argumentos al igual que la
  ! anterior y le sirven para saber desde qué unidad se va leer y con qué
  ! formato. Se puede poner una instrucción para cada variable o separadas por
  ! comas

  READ(*,*) a
  READ(*,*) x,y

  WRITE (*,*) a, x
  WRITE (*,*) y

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
  OPEN(UNIT=12,FILE="param.conf",STATUS="OLD",IOSTAT=err)

  ! la función IF funciona de la misma forma en todos los lenguajes de
  ! programación, si la operación lógica que está entre paréntesis es verdera
  ! entonces se ejecuta una instrucción
  IF (err.NE.0) STOP 'param.conf no se ha encontrado' 

  ! lectura de los datos de la unidad 12
  READ(12,*) a
  READ(12,*) x
  READ(12,*) y

  WRITE (*,*) a
  WRITE (*,*) x
  WRITE (*,*) y


  ! siempre hay que cerrar los archivos, principalmente cuando estamos
  ! escribiendo nuestros resultados
  CLOSE(12)


END PROGRAM hola





