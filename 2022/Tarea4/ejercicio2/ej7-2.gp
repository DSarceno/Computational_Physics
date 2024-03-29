# jue 27 oct 2022 14:34:10 CST
# ej7-2.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej7-2.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej7-2.pdf"

set grid
#set ratio -1
set title "20 Iter (Ejercicio 7.2)"
set xlabel "u(x,t)"
set ylabel "x"
#set key left top box


plot 'solucion.dat' u 2:3 w lp lc "blue"
