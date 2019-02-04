FROM jsschrepping/bioinfo-base-image:latest

COPY Snakefile /Snakefile

ENTRYPOINT ["snakemake", "--snakefile", "/Snakefile", "--directory", "/output", "--jobs", "10"]
CMD [""]
