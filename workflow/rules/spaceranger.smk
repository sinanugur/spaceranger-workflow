
from collections import defaultdict
from yaml import load


idd=config["id"]
transcriptome=config["transcriptome"]
fastqs=config["fastqs"] #fastqs directory
sample=config["sample"]
slide=config["slide"]
area=config["area"]
probe=config["probe"]
image=config["image"]
params=config.get("params","")
get_mem_mb=100

files, = glob_wildcards(fastqs + "/" + sample + "{suffix}.fastq.gz")


rule all:
    input:
        expand(fastqs + "/" + sample + "{suffix}.fastq.gz",suffix=files)
    output:
        idd + "/outs/web_summary.html"
    threads: 30
    resources:
        mem_mb=get_mem_mb*1000
    shell:
        """
        rm -r {idd}
    spaceranger count --id={idd} --transcriptome={transcriptome}/ --fastqs={fastqs}/ --sample={sample} --slide={slide} --image="{image}" --area={area} --localcores={threads} --localmem={get_mem_mb} --probe-set={probe} {params}
    
        """  