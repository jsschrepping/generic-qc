#!/bin/bash

set -ex

snakemake \
    --snakefile /Snakefile \
    --jobs $JOBS \
    --directory /output
