# set Fermi energy to correct value
Efermi=0.0
# ... and uncomment the following line
#set yzeroaxis lt -1

set grid
set xlabel "Energy (eV)"
set ylabel "DOS"
set style fill solid 0.4
set format y "%.1f"

set title "Total DOS\n( press <Enter> in the terminal to exit ... )"

plot [:][:] \
     'Cobult.dos' u ($1-Efermi):2 notit w filledcurve lt 1, \
     'Cobult.dos' u ($1-Efermi):2 notit w l lt 1 lw 2
pause -1