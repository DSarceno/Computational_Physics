# mar 15 nov 2022 09:54:07 CST
# ej7-16.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej7-16.gp


# PROGRAM
# Idioma
set encoding utf8

set yrange [-0.5:0.5]
set xrange [-50:50]

do for [i=0:100] {
#    plot 'solucion.dat' index i u 2:3 w lp, '' index i u 2:4 w lp
    plot 'solucion.dat' index i u 2:($3**2+$4**2) w lp

    pause 0.1
    print i
}
