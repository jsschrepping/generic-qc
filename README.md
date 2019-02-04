Given `/input` directory of the form

    input
    ├── run1
    │   ├── 3651_ATTCCT_L002_R1_001.fastq.gz
    │   ├── 3651_ATTCCT_L002_R1_002.fastq.gz
    │   └── 3651_ATTCCT_L002_R1_003.fastq.gz
    └── run2
        ├── 3652_ACTGAT_L002_R1_001.fastq.gz
        ├── 3652_ACTGAT_L002_R1_002.fastq.gz
        └── 3652_ACTGAT_L002_R1_003.fastq.gz

does the following.

For each directory (`run1`, `run2`) merge all files differing only by
the last three digits (`_001.fastq.gz`, `_002.fastq.gz`, ...) and run
fastqc on them.  Then combine the qc from all the files into one
report with multiqc and place the results in `/output`.
