

set xrange [0:1]
set yrange [0:1]
set zrange [-1.2:1.2]
dt=0.01

set size ratio -1
set pm3d
set cbrange [-0.2:0.2]
set palette defined ( -1 "#08306b", 0 "#ffffff", 1 "#cc3010" )

do for [i=0:400] {
    set title sprintf( "t = %f", i*dt )
    #splot 'solucion.dat' index i u 2:3:4 w l
    plot 'solucion.dat' index i u 2:3:4 w image

    pause -1
    print "ti=",i*dt
}







