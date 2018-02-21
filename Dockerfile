FROM pwlb/rna-seq-pipeline-base

COPY scripts /scripts

ENV JOBS=1 THREADS=1

ENTRYPOINT ["bash","/scripts/run-all.sh"]
CMD [""]
