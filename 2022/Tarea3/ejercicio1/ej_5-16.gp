# lun 17 oct 2022 14:24:01 CST
# ej_5-16.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej_5-16-1.gp


# PROGRAM
# Idioma
set encoding utf8

# Terminal
unset label
clear
set terminal pdf
set output "../img/ej5-16-1.pdf"


set grid
set size ratio -1
set title "Sistema Tierra - Satélite sin la Luna"
set xlabel "x"
set ylabel "y"

plot "solucion" u ($2/1e6):($3/1e6) w lp lw 3 lc "black" t "Tierra", "solucion" u ($6/1e6):($7/1e6) w lp lc "blue" t "Nave"


p "solucion" u ($2/1e6):($3/1e6) w lp lw 3 lc "black" t "Tierra", "solucion" u ($6/1e6):($7/1e6) w lp lc "blue" t "Nave"
p "solucion" u ($2/1e6):($3/1e6) w lp lw 3 lc "black" t "Tierra", "solucion" u ($4/1e6):($5/1e6) w lp lc "blue" t "Luna", "solucion" u ($6/1e6):($7/1e6) w lp lc "red"
