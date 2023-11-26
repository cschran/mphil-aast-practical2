#!/bin/bash

# Simulation length
L=XXX

# Number of beads
Pconv=XX

for P in 1 $Pconv
do
    # Create directory
    dir=$(printf "sim-P%02d" $P)
    mkdir $dir
    sed -e "s/XXXSTEPSXXX/$L/g" -e "s/XXXREPLICAXXX/$P/g" ../._template/pimd.inp > $dir/pimd.inp
    cd $dir
    ln -s ../../._template/ice-Ih.pdb .
    cd ..
done
