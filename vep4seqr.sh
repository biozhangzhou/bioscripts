#/bin/bash

# vep annotation for improt to seqr

#PBS -l walltime=2:00:00,nodes=1:ppn=1
#PBS -joe .
#PBS -d .
#PBS -l vmem=10g,mem=10g

if [ -z $vcf ];
then
    vcf=$1
fi

bname=`echo $vcf | sed s/.vcf.gz//`

unset PERL5LIB && export PATH=/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/anaconda/bin:$PATH && /home/naumenko/work/tools/bcbio/anaconda/bin/variant_effect_predictor.pl \
    --everything --vcf --allele_number --no_stats --cache --offline --force_overwrite --cache_version 81 --assembly GRCh37 --tabix \
    --plugin LoF,human_ancestor_fa:/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Hsapiens/GRCh37/variation/human_ancestor.fa.gz,filter_position:0.05,min_intron_size:15 \
    --plugin dbNSFP,/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Hsapiens/GRCh37/variation/dbNSFP.txt.gz,Polyphen2_HVAR_pred,CADD_phred,SIFT_pred,FATHMM_pred,MutationTaster_pred,MetaSVM_pred \
    -i $vcf -o $bname.vep.vcf.gz \
    --dir /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Hsapiens/GRCh37/vep 
