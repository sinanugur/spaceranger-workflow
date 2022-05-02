


idd=config["id"]
csv_file=config.get("csv","batch.csv")

rule aggr:
    input:
        csv_file
    output:
        {idd} + "/outs/web_summary.html"
    shell:
        """
        spaceranger aggr --id={idd} --csv {input} --normalize=mapped

        """