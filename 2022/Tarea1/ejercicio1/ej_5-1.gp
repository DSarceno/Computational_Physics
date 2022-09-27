# lun 26 sep 2022 15:49:38 CST
# ej_5-1.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-1.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-1.pdf"

set grid
#set ratio -1
set title "Gráfica Método de Euler (Ejercicio 5.1)"
set xlabel "x"
set ylabel "y"
set key left top box


#set style line 1 lc rgb "red" pt 7




plot "h1.dat" w p t "h = 0.05", "h2.dat" w p t "h = 0.1", "h3.dat" w p t "h = 0.15", "h4.dat" w p t "h = 0.20", tan(x) w l lc "black" t "tan(x)"
