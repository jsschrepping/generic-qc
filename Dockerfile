FROM pwlb/rna-seq-pipeline-base:v0.1.1

COPY scripts /scripts
COPY Snakefile /Snakefile

ENV JOBS=1

ENTRYPOINT ["bash","/scripts/run-all.sh"]
CMD [""]
