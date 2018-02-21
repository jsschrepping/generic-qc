#!/bin/bash

# for kallisto
files="/tmp/logfilelist"
find /output/fastqc -name "*_fastqc.zip" >> $files

multiqc \
    -f \
    -o /output/multiqc \
    --file-list $files
