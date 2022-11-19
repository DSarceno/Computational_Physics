# mar 15 nov 2022 11:25:33 CST
# ej7-20.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej7-20.gp


# PROGRAM
# Idioma
set encoding utf8

set yrange [-0.5:0.5]
set xrange [-20:20]
dt = 5

do for [i=0:80] {
    set title sprintf( "t = %f (fs)", i*dt )
  #  plot 'solucion.dat' index i u 2:3 w lp, '' index i u 2:4 w lp
    plot 'solucion.dat' index i u 2:($3**2+$4**2) w lp title "Onda",  step(x) = x>0 ? .2 : 0

    pause -1
}
