set term pngcairo size 800,600 enhanced font "Verdana,12"


set xrange [-200:200]
set yrange [-200:200]
set xlabel 'x (10^6 km)'
set ylabel 'y (10^6 km)'


set size ratio -1

# escala, para que la escala de los ejes sea en millones de kilometros
s = 1e9

# factor de magnificacion de la separacion Tierra-Luna
f = 15

xt=0
yt=0
xl=0
yl=0

do for [i=1:365] {
    set output sprintf( "frames/frame-%04d.png", i )
    set label 1 at -150,-175 sprintf( "La distancia Tierra-Luna está magnificada 15 veces" ) font ',8'
    #set arrow 1 from xt,yt to xl,yl
    
    plot 'solucion' every ::1::i u ($2/s):($3/s) w p pt 7 ps 3 lc rgbcolor '#ff9900' t 'Sol', \
	 '' every ::1::i u (xt=$4/s):(yt=$5/s) w l t 'Tierra', \
	 '' every ::1::i u (xl=(f*($6-$4)+$4)/s):(yl=(f*($7-$5)+$5)/s) w l lc 7 t 'Luna', \
	 '' u (xt):(yt):(xl-xt):(yl-yt) w vectors
    print i
}