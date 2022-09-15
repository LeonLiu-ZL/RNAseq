#!/bin/bash
bamDir=/path/to/result/bam/folder
genomeDir=/path/to/reference/genome/index/file/folder

mkdir $bamDir
for i in *_1.fq.gz; do
# Them computer memory is low, cann't use “--readFilesCommand zcat”.
    gunzip $i ${i%_1.fq.gz}_2.fq.gz
    STAR \
    --genomeDir $genomeDir/ \
    --readFilesIn ${i%_1.fq.gz}_1.fq ${i%_1.fq.gz}_2.fq \
    --runThreadN 6 \
    --outSAMtype BAM Unsorted \
    --outFileNamePrefix $bamDir/${i%_1.fq.gz}_ 
    gzip ${i%_1.fq.gz}_1.fq ${i%_1.fq.gz}_2.fq
done

cd $bamDir
for i in *Aligned.out.bam; do
    samtools sort $i -o ${i%_Aligned.out.bam}.sorted.bam
    samtools index ${i%_Aligned.out.bam}.sorted.bam
done