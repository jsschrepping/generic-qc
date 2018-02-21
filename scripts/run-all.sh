#!/bin/bash

set -a

input=/input
output=/output
tmpdir=$output/tmp
outputfqc=$output/fastqc
log=${output}/logs

mkdir -p $output $log $tmpdir $outputfqc

basepaths=$(find $input -name "*.fastq.gz" \
                | sort \
                | uniq \
                | sed -e 's/_[0-9]\{3\}.fastq.gz//g' \
                | sort \
                | uniq )

function runfastqc {
    basename=$1

    echo "starting: $basepath"

    tomerge=$(find $input -path "*${basename}*.fastq.gz"|sort)

    regularizedname=$(echo ${basename}|sed -e 's|/input/||g' -e 's|/|_|g')

    mergedfile=${tempdir}/${regularizedname}.fastq.gz

    echo -e "$tomerge" > ${log}/${regularizedname}_merged.log

    if [ "$(echo $tomerge| wc -w)" == "1" ]; then
        # nothing to merge, create a link instead
        ln -s $tomerge $mergedfile
    else
        # actually merge the files
        cat $tomerge > $mergedfile
    fi


    fastqc \
        -o $outputfqc \
        -t $THREADS \
        $mergedfile

    rm $mergedfile
}

export -f runfastqc

parallel --eta --will-cite -j $JOBS runfastqc ::: $basepaths

filelist=$tmpdir/logfilelist
find $outputfqc -name "*_fastqc.zip" >> $filelist

multiqc \
    -f \
    -o $output \
    --file-list $filelist

rm -rf $outputfqc
rm -rf $tmpdir
