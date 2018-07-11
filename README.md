Given `/input` directory of the form

    input
    ├── xxx
    │   ├── 3651_ATTCCT_L002_R1_001.fastq.gz
    │   ├── 3651_ATTCCT_L002_R1_002.fastq.gz
    │   └── 3651_ATTCCT_L002_R1_003.fastq.gz
    └── yyy
        ├── 3652_ACTGAT_L002_R1_001.fastq.gz
        ├── 3652_ACTGAT_L002_R1_002.fastq.gz
        └── 3652_ACTGAT_L002_R1_003.fastq.gz

does the following.

For each directory (`xxx`, `yyy`) merge all files differing only by
the last three digits (`_001.fastq.gz`, `_002.fastq.gz`, ...) and run
fastqc on them.  Then combine the qc from all the files into one
report with multiqc and place the results in `/output`.
