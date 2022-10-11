# lun 10 oct 2022 16:59:41 CST
# ej_5-5.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-5.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-5.pdf"

set grid
#set ratio -1
set title "Caída Libre con Fricción (Ejercicio 5.5)"
set xlabel "t$"
set ylabel "v"
set key left top box
v(x) = (-31.305 + (31.305*exp(0.62099*x)))/(1 + exp(0.62099*x))

plot "data.dat" w lp t "Caída Libre", v(x) w l lc "blue" t "Solución Real"
