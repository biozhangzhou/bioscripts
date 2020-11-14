#!/bin/bash

#PBS -l walltime=2:00:00,nodes=1:ppn=1
#PBS -joe .
#PBS -d .
#PBS -l vmem=10g,mem=10g

zcat $1 | wc -l | awk '{print $0/4}' > $1.nreads