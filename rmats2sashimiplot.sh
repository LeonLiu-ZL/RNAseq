#!/bin/bash

# navigate to the output directory of rMATS
bamDir=/path/to/bam/folder
ctrl=control_prefix
tr=treatment_prefix

for i in *.top20.txt; do
    countMethod=${i#*MATS.}
    rmats2sashimiplot \
    --b1 ${bamDir}/${tr}_1.bam,${bamDir}/${tr}_2.bam,${bamDir}/${tr}_3.bam \
    --b2 ${bamDir}/${ctrl}_1.bam,${bamDir}/${ctrl}_2.bam,${bamDir}/${ctrl}_3.bam \
    -t ${i%.MATS*} \
    -e ./$i \
    --l1 ${tr} --l2 ${ctrl} \
    -o ./SashimiPlot/${i%.MATS*}_${countMethod%.top20*}
done