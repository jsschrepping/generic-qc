from pathlib import Path
from snakemake.shell import shell

runs, samples, _ = glob_wildcards("/input/{run}/{sample}_{num,\d{3}}.fastq.gz")

def get_files(wildcards):
    glob = Path("/input").glob(f"""{wildcards.run}/{wildcards.sample}_*.fastq.gz""")
    files = list(map(str,glob))
    if len(files) == 0:
        raise Exception(f"""No files found for sample {wildcards.sample}""")
    files.sort()
    return files

rule all:
    input:
        "multiqc/multiqc.html",
        expand("fastqc/{run}/{sample}_fastqc.zip",zip,run=runs,sample=samples)
    shell:
        "chmod -R a+w . &&"
        "chown -R nobody ."

rule multiqc:
    input:
        expand("fastqc/{run}/{sample}_fastqc.zip",zip,run=runs,sample=samples)
    output:
        "multiqc/multiqc.html"
    log:
        "logs/multiqc.log"
    params:
        ""
    wrapper:
        "0.27.0/bio/multiqc"

rule fastqc:
    input:
        "data/{run}__{sample}.fastq.gz"
    output:
        html="fastqc/{run}/{sample}_fastqc.html",
        zip="fastqc/{run}/{sample}_fastqc.zip"
    log:
        "logs/fastqc/{run}/{sample}.log"
    threads:
        4
    params:
        "-t 4"
    wrapper:
        "0.27.0/bio/fastqc"

rule merge:
    input:
        get_files
    output:
        temp("data/{run}__{sample}.fastq.gz")
    run:
        if len(input) == 1:
            shell("ln -s {input} {output}")
        else:
            shell("cat {input} > {output}")

rule clean:
    shell:
        "rm -rf fastqc logs data"
