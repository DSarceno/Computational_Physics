

set yrange [-2.5:2.5]
dt=0.0025

do for [it=0:400] {
    set title sprintf( "t = %f", it*dt )
    plot 'solucion.dat' index it u 2:3 w l

    pause 0.05
    print "ti=",it*dt
}