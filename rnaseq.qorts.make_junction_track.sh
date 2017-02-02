#!/bin/bash

#PBS -l walltime=1:00:00,nodes=1:ppn=1
#PBS -joe .
#PBS -d .
#PBS -l vmem=15g,mem=15g

#creates junction track for IGV browser

java -Xmx1g -jar ~/work/tools/bin/QoRTs.jar \
    makeJunctionTrack \
    --filenames $1 \
    ~/work/tools/bcbio/genomes/Hsapiens/GRCh37/rnaseq/ref-transcripts.qorts.gff.gz \
    $2
