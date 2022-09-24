#!/bin/bash

: << 'header'
Autor:			   Diego Sarceno
Fecha:		     31-08-2022
Tipo Archivo:	 Script Bash
Ejecución:		 ./ejercicio2.sh
Resumen:		   Archivo que automatiza la creacion de archivos para programar en "c".
header

# Solicitud del nombre del archivo
read -p "Ingrese nombre del archivo: " name
if [ -z $name ]; then
    echo "No ingreso un nombre valido"
    exit 2
fi

# HEADERS
fecha=$(date)

# Python3
python="#	$fecha\n#	$name.py \n#	Diego Sarceno (dsarceno68@gmail.com) \n\n#	Resumen \n\n#	Codificado del texto: UTF8 \n#	Compiladores probados: python3 (Ubuntu 20.04 Linux) 3.8.10 \n#	Instruciones de Ejecución: no requiere nada mas \n#	python3 $name.py \n\n#	Librerias \nimport math as m \nimport numpy as np \n "

# Fortran
fortran="!	$fecha \n!	$name.f95 \n!	Diego Sarceno (dsarceno68@gmail.com) \n\n!	Resumen \n\n!	Codificado del texto: UTF8 \n!	Compiladores probados: GNU Fortran (Ubuntu 20.04 Linux) 9.4.0 \n!	Instruciones de Ejecución: no requiere nada mas \n!	gfortran -Wall -pedantic -std=f95 -c -o $name.o $name.f95 \n! gfortran -o $name.x $name.o \n\n!	PROGRAM $name \n\n! END $name \n "

# C
c="// $fecha \n// $name.c \n// Diego Sarceno (dsarceno68@gmail.com) \n\n// Resumen \n\n// Codificado del texto: UTF8 \n// Compiladores probados: gcc (Ubuntu 20.04 Linux) 9.4.0 \n// Instruciones de Ejecución: no requiere nada mas \n// gcc -Wall -pedantic -std=c11 -c -o $name.o $name.c \n// gcc -o $name.x $name.o -lm \n\n\n//	Librerias \n#include <stdio.h> \n#include <math.h> \n"

# C++
cpp="// $fecha \n// $name.cpp \n// Diego Sarceno (dsarceno68@gmail.com) \n\n// Resumen \n\n// Codificado del texto: UTF8 \n// Compiladores probados: g++ (Ubuntu 20.04 Linux) 9.4.0 \n// Instruciones de Ejecución: no requiere nada mas \n// g++ -Wall -c -o $name.o $name.cpp \n// g++ -o $name.x $name.o \n\n\n//	Librerias \n#include <iostream> \n\nusing namespace std; \n"

# Gnuplot
gnuplot="#	$fecha \n#	$name.gp \n#	Diego Sarceno (dsarceno68@gmail.com) \n\n#	Resumen \n\n#	Codificado del texto: UTF8 \n#	Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2 \n#	Instruciones de Ejecución: no requiere nada mas \n#	gnuplot $name.gp \n\n\n# PROGRAM \n# Idioma \nset encoding utf8 \n\n# Terminal \nunset label \nclear \nset terminal pdf \n\n "

# R
r="#	$fecha \n#	$name.R \n#	Diego Sarceno (dsarceno68@gmail.com) \n\n#	Resumen \n\n#	Codificado del texto: UTF8 \n#	Compiladores probados: R (Ubuntu 20.04 Linux) 4.0.3 \n#	Instruciones de Ejecución: no requiere nada mas \n#	Rscript $name.R \n\n\n "





# Solicitud de la extencion del archivos
echo "¿Que extension de archivo desea utlizar"
echo "1. Python"
echo "2. Fortran"
echo "3. C"
echo "4. C++"
echo "5. Gnuplot"
echo "6. R"
read choice
if [ -z $choice ]; then
  echo "No ingreso un numero valido"
  exit 2
# 1
elif (($choice == 1)); then
  fname=$name".py"
  if [ -e $fname ]; then
      echo "El archivo ya existe"
      exit 2
  fi
  echo -e $python >> $fname
# 2
elif (($choice == 2)); then
  fname=$name".f95"
  if [ -e $fname ]; then
      echo "El archivo ya existe"
      exit 2
  fi
  echo -e $fortran >> $fname
# 3
elif (($choice == 3)); then
  fname=$name".c"
  if [ -e $fname ]; then
      echo "El archivo ya existe"
      exit 2
  fi
  echo -e $c >> $fname
# 4
elif (($choice == 4)); then
  fname=$name".cpp"
  if [ -e $fname ]; then
      echo "El archivo ya existe"
      exit 2
  fi
  echo -e $cpp >> $fname
# 5
elif (($choice == 5)); then
  fname=$name".gp"
  if [ -e $fname ]; then
      echo "El archivo ya existe"
      exit 2
  fi
  echo -e $gnuplot >> $fname
# 6
elif (($choice == 6)); then
  fname=$name".R"
  if [ -e $fname ]; then
      echo "El archivo ya existe"
      exit 2
  fi
  echo -e $r >> $fname
fi
