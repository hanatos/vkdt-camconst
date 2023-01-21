#!/bin/bash

BD=../../vkdt/bin

model=$1

${BD}/vkdt-lutinfo "$model.lut" > "${model}.txt"
${BD}/vkdt-eval-profile "$model" -e > "${model}-eval.dat"

cat << EOF | gnuplot
set output "${model}.png"
set term pngcairo size 1152,1024
set nokey
set size square
set border 0
set lmargin screen 0
set rmargin screen 1
set tmargin screen 0
set bmargin screen 1
load 'viridis.pal'
unset tics
set cbtics auto
set cbrange [0:10]
set multiplot
set xrange [0:1]
set yrange [0:1]
rgb(r,g,b) = int(r*256)*65536 + int(g*256)*256 + int(b*256)
plot "${model}-gamut.dat" u 1:2:(rgb(\$3,\$4,\$5)) w p pt 5 ps 1 lc rgb variable
plot "${model}-eval.dat" u 3:4:2 w p pt 7 ps 7 palette
set palette gray
unset colorbox
plot "${model}-eval.dat" u 3:4:1:(10-\$2) w labels offset char 0,0.3 font ',12' tc palette,\\
             '' u 3:4 w p pt 1 ps 1 lc rgb "\#cc2211"
unset multiplot
EOF
rm -f "./${model}.txt" "./${model}-eval.dat" "./${model}-gamut.dat"
