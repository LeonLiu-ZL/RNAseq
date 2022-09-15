#!/bin/bash

gff=/path/to/ReferenceGenome/majiq/gff3/file
majiqDir=/path/to/result/output/folder
group1=control_group_name
group2=treatment_group_name
gr1bamPrefix=control_group_bam_prfix
gr2bamPrefix=treatment_group_bam_prefix

majiq build ${gff} \
-o ${majiqDir}/build \
-c ${majiqDir}/majiq_build_config.ini \
-j 6

majiq deltapsi -o ${majiqDir}/deltapsi \
-j 6 \
-grp1 \
${majiqDir}/build/${gr1bamPrefix}_1.majiq \
${majiqDir}/build/${gr1bamPrefix}_2.majiq \
${majiqDir}/build/${gr1bamPrefix}_3.majiq \
-grp2 \
${majiqDir}/build/${gr2bamPrefix}_1.majiq \
${majiqDir}/build/${gr2bamPrefix}_2.majiq \
${majiqDir}/build/${gr2bamPrefix}_3.majiq \
-n ${group1} ${group2}

voila tsv \
-f ${majiqDir}/voila/${group1}_${group2}.tsv \
-j 6 \
${majiqDir}/build/splicegraph.sql \
${majiqDir}/deltapsi/${group1}_${group2}.deltapsi.voila