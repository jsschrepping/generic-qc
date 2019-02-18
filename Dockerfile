# Set the base image to debian based miniconda3
FROM continuumio/miniconda3:4.5.12

# File Author/Maintainer
MAINTAINER Jonas Schulte-Schrepping

# This will make apt-get install without question
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    git \
    cmake \
    zlib1g \
    libhdf5-dev \
    build-essential \
    wget \
    curl \
    unzip \
    jq \
    bc \
    openjdk-8-jre \
    perl \
    libxml2-dev \
    aria2 \
    subread \
    libcurl4-openssl-dev \
    less \
    gcc \
    gawk && \
    apt-get clean

# Update conda
RUN conda update -n base -c defaults conda

# Set channels
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

# Install conda packages
RUN conda install -y numpy=1.16.1 \
    	  	     scipy=1.2.0 \ 
		     cython=0.29.4 \
		     numba=0.41.0 \
		     matplotlib=3.0.2 \
		     scikit-learn=0.20.2 \
		     h5py=2.9.0 \
		     click=7.0 \
		     emacs=26.1 \
		     git=2.20.1 \
		     multiqc=1.6 \
		     snakemake=5.4.0 \
		     r-devtools=2.0.1  && \
    conda install -c bioconda -y samtools=1.9 \
    	  	     	      	 fastqc=0.11.8 

COPY Snakefile /Snakefile

ENTRYPOINT ["snakemake", "--snakefile", "/Snakefile", "--directory", "/output", "--jobs", "10"]
CMD [""]
