#!/bin/bash

gatk VariantsToTable \
-V $1 \
-O $1.tsv \
-F CHROM -F POS -F REF -F ALT -F DP -F CSQ -GF AD -GF AF
