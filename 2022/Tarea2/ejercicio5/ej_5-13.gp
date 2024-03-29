# lun 10 oct 2022 21:50:53 CST
# ej_5-13.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: requiere el directorio frames/ y 'ffmpeg'
# gnuplot ej_5-13.gp

# En el directorio 'frames' donde estan las imagenes, ejecutar el siguiente
# comando, esto generara la animacion en un archivo .mp4
# ffmpeg -framerate 30 -pattern_type glob -i '*.png' -c:v libx264 -pix_fmt yuv420p out.mp4


# PROGRAM
set term pngcairo size 800,600 enhanced font "Verdana,12"


set xrange [-1:1]
set yrange [-1:1]
set xlabel 'x (m)'
set ylabel 'y (m)'


set size ratio -1

# longitud del pendulo
lon=1.0;

do for [i=0:1000] {
    set output sprintf( "frames/frame-%04d.png", i )
    set title sprintf( "tiempo = %f", i*0.02 )

    plot 'data2' every ::i::i u (x1=lon*sin($2)):(y1=-lon*cos($2)) w p lc 5 lw 5 t '', \
	 '' every ::i::i u (0.0):(0.0):(x1):(y1) w vectors nohead t ''

    print i
}
