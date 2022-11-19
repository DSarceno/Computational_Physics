!    2021-02-12
!    sesion03.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Este es un programa paso a paso con pruebas de ciclos y cambios en el
!    flujo del programa

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.5.0
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o Sesion03.o Sesion03.f90
!    gfortran -o Sesion03.x Sesion03.o 

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


PROGRAM Sesion03

  IMPLICIT NONE

  ! variables de ciclos
  INTEGER(4):: c,d
  

  ! Los cambios en el flujo del programa son importantes y la forma de cambio
  ! más usada es el condicional IF
  c=1
  d=2
  IF (c.EQ.d) THEN
     WRITE (*,*) "es verdadero"
  ELSE
     WRITE (*,*) "es falso"
  END IF
  
  ! otra forma interesante de cambiar el flujo del programa es con select
  SELECT CASE (c)
  CASE (1)
     WRITE (*,*) "en el caso de que sea uno"
  CASE (2)
     WRITE (*,*) "en el caso de que sea dos"
  CASE DEFAULT
     WRITE (*,*) "opción predefinida cuando no se cumplen otras"
  END SELECT

  


  ! Uno de los ciclos más importantes en fortran es el ciclo DO que se usa
  ! cuando se conoce el número de veces que se quiere repetir el código

  ! los ciclos pueden contar en forma ascendente
  DO c=1,10,1
     WRITE (*,'(I6)', ADVANCE='NO') c
  END DO
  WRITE (*,*)

  ! o también en forma descendente
  DO c=10,1,-1
     WRITE (*,'(I6)', ADVANCE='NO') c
  END DO
  WRITE (*,*)

  ! los ciclos se pueden anidar
  DO c=1,3,1
     DO d=3,1,-1
        WRITE (*,'(I6)', ADVANCE='NO') c*d
     END DO
  END DO
  WRITE (*,*)

  ! la función CYCLE hace que el ciclo empiece la siguiente iteración
  DO c=1,3,1
     DO d=3,1,-1
        IF (d.NE.c) CYCLE
        WRITE (*,'(I6)', ADVANCE='NO') c*d
     END DO
  END DO
  WRITE (*,*)

  ! la función EXIT sale del ciclo y continúa con la siguiente instrucción después del END DO
  DO c=1,3,1
     DO d=3,1,-1
        IF (d.NE.c) EXIT
        WRITE (*,'(I6)', ADVANCE='NO') c*d
     END DO
  END DO
  WRITE (*,*)
  

  ! otro 
END PROGRAM Sesion03

  
