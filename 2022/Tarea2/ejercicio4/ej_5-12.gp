# lun 10 oct 2022 19:08:42 CST
# ej_5-12.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-12.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-12-1.pdf"

set grid
#set ratio -1
set title "Oscilador Armónico Simple (Ejercicio 5.12)"
set ytics nomirror
set y2tics
set xlabel "t"
set ylabel "θ"
set y2label "ω"
set key left top box


plot "data1" u 1:2 w lp t "θ - t", "data1" u 1:3 w lp lc "blue" t "ω - t"



# Terminal
#unset label
#clear
#set terminal pdf
#set output "../img/ej5-12-2.pdf"
#set grid
#set size ratio -1
#set title "Oscilador Armónico Simple (Ejercicio 5.12)"
#set xlabel "θ"
#set ylabel "ω"
#set key left top box


#plot "data1" u 2:3 w lp t "ω - θ"
