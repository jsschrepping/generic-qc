Given `/input` directory of the form

    input
    ├── run1
    │   ├── {sample1}_001.fastq.gz
    │   ├── {sample1}_002.fastq.gz
    │   └── {sample1}_003.fastq.gz
    └── run2
        ├── {sample2}_001.fastq.gz
        ├── {sample2}_002.fastq.gz
        └── {sample3}_001.fastq.gz

does the following.

For each directory (`run1`, `run2`) merge all files differing only by
the last three digits (`_001.fastq.gz`, `_002.fastq.gz`, ...) and run
fastqc on them.  Then combine the qc from all the files into one
report with multiqc and place the results in `/output`.
