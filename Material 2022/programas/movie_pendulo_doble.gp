set term pngcairo size 800,600 enhanced font "Verdana,12"


set xrange [-1:1]
set yrange [-1:1]
set xlabel 'x (m)'
set ylabel 'y (m)'


set size ratio -1

# longitud del pendulo
lon=0.3;

do for [i=2001:4000] {
    set output sprintf( "frames/frame-%04d.png", i )
    set title sprintf( "tiempo = %f", i*0.02 )
    
    plot 'solucion' every ::i-100::i u (x1=lon*sin($2)):(y1=-lon*cos($2)) w l lc 5 t '', \
	 '' every ::i-100::i u (x2=lon*(sin($2)+sin($3))):(y2=-lon*(cos($2)+cos($3))) w l lc 6 t '', \
	 '' every ::i::i u (0.0):(0.0):(x1):(y1) w vectors nohead t '', \
	 '' every ::i::i u (x1):(y1):(x2-x1):(y2-y1) w vectors nohead t ''

    print i
}