# mié 26 oct 2022 16:33:18 CST
# ej7-1.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot ej7-1.gp


# PROGRAM
# Idioma
set encoding utf8
set terminal gif

set yrange [-2.5:2.5]
dt=0.0001
set ylabel "y(m)"
set xlabel "x(m)"
do for [it=0:200] {
    set title sprintf( "t = %f (s)", it*dt )
    plot 'solucion.dat' index it u 2:3 w l  title "Visualización de la Onda"

    pause 0.05
}
