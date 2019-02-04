from pathlib import Path
from snakemake.shell import shell

# In order to infer the IDs from present files, Snakemake provides the glob_wildcards function. The function matches the given pattern against files present in the filesystem and thereby infers the values for all wildcards in the pattern. A named tuple that contains a list of values for each wildcard is returned.
runs, samples, ids, lanes, reads, nums = glob_wildcards("/input/{run}/{sample}_{id}_{lane}_{read}_{num,\d{3}}.fastq.gz")

# define function to retrieve all the files from input directory
def get_files(wildcards):
    glob = Path("/input").glob(f"""{wildcards.run}/{wildcards.sample}_{wildcards.id}_{wildcards.lane}_{wildcards.read}_*.fastq.gz""")
    files = list(map(str,glob))
    if len(files) == 0:
        raise Exception(f"""No files found for sample {wildcards.sample}""")
    files.sort()
    return files

# Snakemake rules
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
        "0.31.1/bio/multiqc"

rule fastqc:
    input:
        "data/{run}_{sample}.fastq.gz"
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
        "0.31.1/bio/fastqc"

# Instead of specifying strings or lists of strings as input files, snakemake can also make use of functions that return single or lists of input files. Instead of specifying strings or lists of strings as input files, snakemake can also make use of functions that return single or lists of input files.
     
rule merge:
    input:
        get_files
    output:
        temp("data/{run}_{sample}.fastq.gz")
    run:
        if len(input) == 1:
            shell("ln -s {input} {output}")
        else:
            shell("cat {input} > {output}")

rule clean:
    shell:
        "rm -rf fastqc logs data"
