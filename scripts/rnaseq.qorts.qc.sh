#!/bin/bash

#PBS -l walltime=10:00:00,nodes=1:ppn=1
#PBS -joe .
#PBS -d .
#PBS -l vmem=15g,mem=15g

#don't use flattened gff file - it flattens on the fly
#the main command of qorts produces all counts

if [ -z $bam ]
then
    bam=$1
fi

#module load java
java -Xmx10g -jar ~/work/tools/bin/QoRTs.jar QC \
	$bam \
	/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Hsapiens/GRCh37/rnaseq/ref-transcripts.gtf \
	${bam}.qorts
