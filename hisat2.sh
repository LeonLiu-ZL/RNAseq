#!/bin/bash

# Navigate to the directory where the fastq files are. 

genomeDir=/path/to/reference/genome/index_file_prefix
bamDir=/path/to/save/bamfile

for i in *_1.fq.gz; do
    hisat2 --thread 4 \
    -x ${genomeDir} \
    -1 $i -2 ${i%1.fq.gz}2.fq.gz \
    -S ${bamDir}/${i%_1.fq.gz}.sam \
    --summary-file ${bamDir}/${i%_1.fq.gz}.ht2.log \
    --new-summary
    samtools sort -@ 4 ${bamDir}/${i%_1.fq.gz}.sam -o ${bamDir}/${i%_1.fq.gz}.bam
    samtools index -@ 4 ${bamDir}/${i%_1.fq.gz}.bam
    rm ${bamDir}/${i%_1.fq.gz}.sam
done