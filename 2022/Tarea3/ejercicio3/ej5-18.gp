# mar 18 oct 2022 17:02:38 CST
# ej5-18.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej5-18.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-18.pdf"


set grid
#set size ratio -1
set title "Sistema Tierra-Luna-Nave, Ida-Vuelta a la Luna"
set xlabel "x"
set ylabel "y"
set key left top box


plot "solucion-comeback" u ($2/1e6):($3/1e6) w lp lw 3 lc "black" t "Tierra", "solucion-comeback" u ($4/1e6):($5/1e6) w lp lc "blue" t "Luna", "solucion-comeback" u ($6/1e6):($7/1e6) w lp lc "red" t "Nave"
