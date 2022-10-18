# mar 18 oct 2022 17:22:01 CST
# animation.gp
# Diego Sarceno (dsarceno68@gmail.com)

# Resumen

# Codificado del texto: UTF8
# Compiladores probados: GNUPLOT (Ubuntu 20.04 Linux) 5.2
# Instruciones de Ejecución: no requiere nada mas
# gnuplot animation.gp

# En el directorio 'frames' donde estan las imagenes, ejecutar el siguiente
# comando, esto generara la animacion en un archivo .mp4
# ffmpeg -framerate 30 -pattern_type glob -i '*.png' -c:v libx264 -pix_fmt yuv420p out.mp4


# PROGRAM
set term pngcairo size 800,600 enhanced font "Verdana,12"


set xrange [-400:400]
set yrange [0:400]
set xlabel 'x (m)'
set ylabel 'y (m)'


set size ratio -1


do for [i=0:220] {
    set output sprintf( "frames/frame-%04d.png", i )
    set title sprintf( "tiempo = %f", i*0.02 )

    plot 'solucion-comeback' every ::i::i u ($2/1e6):($3/1e6) w p lc "blue" lw 3 t '', \
          'solucion-comeback' every ::i::i u ($4/1e6):($5/1e6) w p lc "gray" lw 4 t '', \
          'solucion-comeback' every ::i::i u ($6/1e6):($7/1e6) w p lc "black" lw 5 t ''
    print i
}
