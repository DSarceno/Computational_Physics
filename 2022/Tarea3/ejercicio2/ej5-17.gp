# mar 18 oct 2022 16:17:54 CST
# ej5-17.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej5-17.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-17.pdf"


set grid
#set size ratio -1
set title "Sistema Tierra-Luna-Nave, Llegada a la luna"
set xlabel "x"
set ylabel "y"
set key left top box




plot "solucion-moonlanding" u ($2/1e6):($3/1e6) w lp lw 3 lc "black" t "Tierra", "solucion-moonlanding" u ($4/1e6):($5/1e6) w lp lc "blue" t "Luna", "solucion-moonlanding" u ($6/1e6):($7/1e6) w lp lc "red" t "nave"
