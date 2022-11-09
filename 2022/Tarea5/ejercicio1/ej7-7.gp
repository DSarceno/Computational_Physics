# mar 08 nov 2022 21:44:43 CST
# ej7-7.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej7-7.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej7-7.pdf"


set title "Solución a la Ecuación de Calor de Estado Estacionario"
set xlabel "x"
set ylabel "y"
set zlabel "u(x,y)"


sp "solucion.dat" t "" w pm3d
