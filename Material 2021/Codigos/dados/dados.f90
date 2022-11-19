!    2019-01-21
!    dados.f90
!    Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

!    Lanzar unos dados y probar que la suma de todas las caras es una
!    distribucion normal

!    Codificación del texto: UTF8
!    Compiladores probados: GNU Fortran (SUSE Linux) 7.3.1, GNU Fortran
!    (Debian 4.7.2-5) 4.7.2
!    Instrucciones de compilación: no requiere nada mas
!    gfortran -Wall -pedantic -std=f95 -c -o dados.o dados.f90
!    gfortran -o dados.x dados.o 

!    Copyright (C) 2019
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

PROGRAM dados

  IMPLICIT NONE
  ! variables del problema
  INTEGER(8):: NumeroDados ! numero de dados
  INTEGER(8):: Caras ! numero de caras del dado
  INTEGER(8):: Lanzamientos ! numero de lanzamientos
  INTEGER(8),ALLOCATABLE,DIMENSION(:):: Frecuencias
  REAL(8),ALLOCATABLE,DIMENSION(:):: Dado
  ! otras variables
  INTEGER(8):: I,J,K
  INTEGER(4):: err

  ! en ocasiones es mejor leer los parametros de la simulacion desde un
  ! archivo
  OPEN(21,FILE="config",STATUS="OLD",IOSTAT=err)
  IF (err.EQ.0) THEN
     READ(21,*) Lanzamientos
     READ(21,*) NumeroDados
     READ(21,*) Caras
     CLOSE(21)
  ELSE
     STOP 'Archivo no encontrado'
  END IF

  ! es importante guardar los resultados de una simulacion, pero tambien hay
  ! que guardar los parametros usados para la simulacion
  WRITE (*,*) "# Aproximacion a la Distribucion Normal, lanzamiento de dados"
  WRITE (*,*) "# Lanzamientos", Lanzamientos
  WRITE (*,*) "# Numero de dados", NumeroDados
  WRITE (*,*) "# Numero de caras", Caras

  ! reserva de memoria dinamica
  ALLOCATE(Frecuencias(Caras*NumeroDados),STAT=err)
  IF (err.NE.0) STOP 'Memoria no reservada'
  ALLOCATE(Dado(NumeroDados),STAT=err)
  IF (err.NE.0) STOP 'Memoria no reservada'

  ! comparar esta forma de asignacion de una matriz
  Frecuencias= 0

  ! ciclo principal 
  DO I=1,Lanzamientos
     ! la subrutina llena todo el arreglo unidimensional con numeros
     ! aleatorios
     CALL RANDOM_NUMBER(Dado)
     K=0 ! la inicialiacion de la variable de suma es importante
     ! ciclo para hacer la suma
     DO J=1,NumeroDados
        K=K+INT(1.+REAL(Caras)*Dado(J))
     END DO
     Frecuencias(K)=1+Frecuencias(K)
  END DO

  ! tambien hay que decir que es lo que estamos guardando de la simulacion
  WRITE (*,*) "# Suma, Frecuencia"
  DO I=1,Caras*NumeroDados
     WRITE (*,*) I,Frecuencias(I)
  END DO
  
  ! esto es para liberar la memoria asignada
  DEALLOCATE(Frecuencias)
  DEALLOCATE(Dado)
END PROGRAM dados

! ejemplo de archivo config

! 100
! 2
! 4
