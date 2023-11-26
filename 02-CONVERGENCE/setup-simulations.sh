#!/bin/bash

# Simulation length
L=XXX

# Number of beads
Pstart=1
Pstop=XXX

for ((P = $Pstart; P <= $Pstop; P*=2))
do
    # Create directory
    dir=$(printf "sim-P%02d" $P)
    mkdir $dir
    sed -e "s/XXXSTEPSXXX/$L/g" -e "s/XXXREPLICAXXX/$P/g" ../._template/pimd.inp > $dir/pimd.inp
    cd $dir
    ln -s ../../._template/ice-Ih.pdb .
    cd ..
done
