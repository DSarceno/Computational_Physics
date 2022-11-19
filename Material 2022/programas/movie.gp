set term pngcairo size 800,600 enhanced font "Verdana,12"



set xrange [-1e8:4e8]
set yrange [-2e8:2e8]

set size ratio -1

do for [i=1:1000] {
    set output sprintf( "frames/frame-%04d.png", i )
    plot 'solucion' every ::i::i u 2:3 w p pt 7 ps 3, \
 	 'solucion' every ::i-50::i u 2:3 w p pt 7 ps 0.2


    print i
}