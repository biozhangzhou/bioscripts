#!/bin/bash

# cleans up after bcbio - when running large cohort only the final folder is kept, 
# and only ensemble gemini database: 2-3G per family
# keeps bam files for new samples
# prepares tables for report generation

# parameters:
# family = [family_id] (=folder_name)

#PBS -l walltime=10:00:00,nodes=1:ppn=1
#PBS -joe .
#PBS -d .
#PBS -l vmem=10g,mem=10g

function cleanup
{

    # better to look for project-summary than hardcode the year
    # don't forget to extract bam files from sample directories for new samples
    cd $family
    result_dir=`find final -name project-summary.yaml | sed s/"\/project-summary.yaml"//`
    mv $result_dir/* .
    mv final/*/*.bam .
    mv final/*/*.bai .

    rm -rf final/
    rm -rf work/

    #don't remove input files for new projects
    #rm -rf input/

    # we don't need gemini databases for particular calling algorythms
    rm ${family}-freebayes.db
    rm ${family}-gatk-haplotype.db
    rm ${family}-samtools.db
    rm ${family}-platypus.db

    cd ..
}

function prepare_for_report
{
    cd $family

    gemini.gemini2txt.sh ${family}-ensemble.db 

    gemini.decompose.sh ${family}-freebayes.vcf.gz
    vcf.freebayes.getAO.sh ${family}-freebayes.decomposed.vcf.gz

    gemini.decompose.sh ${family}-gatk-haplotype.vcf.gz
    vcf.gatk.get_depth.sh ${family}-gatk-haplotype.decomposed.vcf.gz

    gemini.decompose.sh ${family}-platypus.vcf.gz
    vcf.platypus.getNV.sh ${family}-platypus.decomposed.vcf.gz

    cd ..
}

if [ -z $family ]
then
    family=$1
fi

echo $family
cleanup
prepare_for_report