# dap_learning
Deep learning motif discovery using [DAP-seq data](http://neomorph.salk.edu/dap_web/pages/browse_table_aj.php)

The shell script in here will take a narrowPeak file and it's associated genome and extract 50bp of sequence flanking the summit of each of the top `-n` peaks.

`sh get_training_data.sh -p $peakfile -name $name -r $genome -cs $chrsizes -n $topn`

`-p [path to narrowPeak file generated with macs2]`
`-name [what do you want the output file to be called?]`
`-r [path to the fasta file of the genome corresponding to the narrowPeak file]`
`-cs [chromsome sizes for the genome]`
`-n [# of top peaks sorted by fold-change (column 7). Suggested topn=1000]`

The output will be deposited in `./training`

Make sure you have bedtools installed in your path.

See the Jupyter Notebook for example analysis.

If you don't already have it installed you will need to install tensorflow:

`pip install --upgrade tensorflow`




