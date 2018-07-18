FROM pwlb/rna-seq-pipeline-base:v0.1.1

COPY Snakefile /Snakefile

ENTRYPOINT ["snakemake", "--snakefile", "/Snakefile", "--directory", "/output", "--jobs", "10"]
CMD [""]
