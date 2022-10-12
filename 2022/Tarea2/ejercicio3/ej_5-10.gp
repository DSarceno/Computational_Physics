# mar 11 oct 2022 21:53:00 CST
# ej_5-10.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-10.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-10.pdf"

set grid
#set ratio -1
set title "Van der Pol (Ejercicio 5.10)"
set xlabel "t"
set ylabel "x"
set key left top box

plot "solucion.dat" u 1:2 w lp t "Van der Pol"
