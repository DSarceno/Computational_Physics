# lun 26 sep 2022 18:40:23 CST
# ej_5-2.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-2.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-2.pdf"

set grid
#set ratio -1
set title "Solución ED por Varios Métodos (Ejercicio 5.2)"
set xlabel "x"
set ylabel "y"
set key left top box

plot "simple.dat" w p t "Euler Simple", "modificado.dat" w p t "Euler Modificado", "mejorado.dat" w p t "Euler Mejorado", tan(x) w l lc "black" t "Solución Real"
