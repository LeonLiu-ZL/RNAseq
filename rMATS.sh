#!/bin/bash

# nthread should be set to 4 to avoid memmory error in this computer (32G memory).
# remove tmp folder and other files in rMATS folder if you re-run the program
# There should not be spaces between 2 bam files in b1.txt and b2.txt.
rmatsDir=/path/to/rMATS/results/saving/folder
gtf=/path/to/reference/genome/gtf/files
bamDir=/path/to/bam/folder

ReadLength=150
ReadType=paired # single or paired
ctrl=control_prefix
tr=treatment_prefix

# Write bam infomration to b1.txt and b2.txt
touch ${rmatsDir}/b1.txt
cat > ${rmatsDir}/b1.txt <<EOF
${bamDir}/${tr}_1.bam,${bamDir}/${tr}_2.bam,${bamDir}/${tr}_3.bam
EOF

touch ${rmatsDir}/b2.txt
cat > ${rmatsDir}/b2.txt <<EOF
${bamDir}/${ctrl}_1.bam,${bamDir}/${ctrl}_2.bam,${bamDir}/${ctrl}_3.bam
EOF

# Run rMATS
python /home/zliu/rmats-turbo/rmats.py \
--b1 ${rmatsDir}/b1.txt \
--b2 ${rmatsDir}/b2.txt \
--gtf ${gtf} \
-t ${ReadType} \
--readLength ${ReadLength} \
--nthread 4 \
--od ${rmatsDir} \
--tmp ${rmatsDir}/tmp 

