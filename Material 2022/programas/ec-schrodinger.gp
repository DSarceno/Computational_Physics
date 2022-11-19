

set yrange [-0.5:0.5]
set xrange [-50:50]

do for [i=0:100] {
#    plot 'solucion.dat' index i u 2:3 w lp, '' index i u 2:4 w lp
    plot 'solucion.dat' index i u 2:($3**2+$4**2) w lp

    pause -1
    print i
}