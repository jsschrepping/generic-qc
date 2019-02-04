FROM jsschrepping/bioinfo-base-image:jss_v0.0.1

COPY Snakefile /Snakefile

ENTRYPOINT ["snakemake", "--snakefile", "/Snakefile", "--directory", "/output", "--jobs", "10"]
CMD [""]
