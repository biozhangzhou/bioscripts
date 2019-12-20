#!/bin/bash

# http://lindenb.github.io/jvarkit/BamStats05.html
# uses bamstats05 - groups coverage by gene
# really fast: 2min for a big bam file and 100 genes
# arguments: bam and bed
# by default uses protein coding genes

# pull exone coordinates with genes.R and do bedtools sort | bedtools merge -c 4 -o first 

#PBS -l walltime=2:00:00,nodes=1:ppn=1
#PBS -joe .
#PBS -d .
#PBS -l vmem=11g

# wants java1.8

BAMSTATS_PATH=~/work/tools/jvarkit/dist

# if you need all reads, add -f "" - empty filter, by default it filters out some duplicated reads

if [ -z $bed ]
then
    bed=~/cre/data/protein_coding_genes.exons.fixed.sorted.bed
fi

java -Xmx10G -jar ${BAMSTATS_PATH}/bamstats05.jar \
    -B $bed \
    $bam > $bam.coverage
