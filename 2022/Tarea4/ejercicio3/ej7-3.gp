# vie 28 oct 2022 12:51:16 CST
# ej7-3.gp.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej7-3.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej7-3d.pdf"

set grid
#set ratio -1
set title "Interferencia Destructiva (Ejercicio 7.3)"
set xlabel "u(x,t)"
set ylabel "x"
set key left top box


plot 'prueba_destructiva' u 2:3 w lp lc "blue" t "Frame"
