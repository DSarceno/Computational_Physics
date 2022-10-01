# vie 30 sep 2022 22:04:17 CST
# ej_5-3.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-3.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-3_1.pdf"

set grid
#set ratio -1
set title "Masa en un Resorte (Ejercicio 5.3)"
set ytics nomirror
set y2tics
set xlabel "Tiempo"
set ylabel "Posición"
set y2label "Velocidad"
set key right top box

plot "data.dat" u 1:2 axis x1y1 w p t "Posición", "data.dat" u 1:3 axis x1y2 w p t "Velocidad"

unset y2label
unset y2tics
clear
set terminal pdf
set output "../img/ej5-3_2.pdf"
set grid
set title "Energía, Masa en un Resorte (Ejercicio 5.3)"
set xlabel "Tiempo"
set ylabel "Energía"
set key left top box

plot "data.dat" u 1:4 w p t "Energía"
