# lun 10 oct 2022 20:22:37 CST
# ej_5-12-1.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-12-1.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-12-3.pdf"

set grid
#set ratio -1
set title "Oscilador Armónico Simple (Ejercicio 5.12)"
set xlabel "θ"
set ylabel "ω"
set xrange [-5:5]
set parametric
set key left top box


a1 = 1
a2 = sqrt(2)
a3 = sqrt(3)
a4 = 2
b1 = pi/3
b2 = pi/2
b3 = 2*pi/3
b4 = pi

#plot [0:2*pi] b1*cos(t), a1*sin(t) t "E = 0.25", [0:2*pi] b2*cos(t), a2*sin(t) t "E = 0.5", [0:2*pi] b3*cos(t), a3*sin(t) t "E = 0.75", [0:2*pi] b4*cos(t), a4*sin(t) t "E = 1"

plot "data1" u 2:3 w l t "E = 0.25", "data2" u 2:3 w l t "E = 0.5", "data3" u 2:3 w l t "E = 0.75", "data4" u 2:3 w l t "E = 1.0", "data5" u 2:3 w l t "E = 1.25", "data6" u 2:3 w l t "E = 1.5"
