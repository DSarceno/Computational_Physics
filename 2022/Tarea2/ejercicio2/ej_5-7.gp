# mar 11 oct 2022 21:42:09 CST
# ej_5-7.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-7.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-7.pdf"

set grid
#set ratio -1
set title "RK Adaptativo (Ejercicio 5.7)"
set xlabel "t"
set ylabel "v"
set yrange [0:100]
set xrange [0:1000]
set key left top box
v(x) = (-31.305 + (31.305*exp(0.62099*x)))/(1 + exp(0.62099*x))
va(x) = 9.8*x

plot "solucion.dat" u 1:3 w lp t "Caída Libre", va(x) w l lc "blue" t "Solución Real"
