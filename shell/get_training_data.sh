#!/bin/bash

while [ -n "$1" ]; do # while loop starts
 
    case "$1" in

    -p)
        peakfile="$2"
 
        shift
        ;;

    -r)
        genome="$2"
 
        shift
        ;;

    -cs)
        chrsizes="$2"
 
        shift
        ;;

    -n)
        topn="$2"
 
        shift
        ;;

    -name)
        name="$2"
 
        shift
        ;;

    *) echo "Option $1 not recognized" ;;
 
    esac
 
    shift
 
done

total=1
 
for param in "$@"; do
 
    echo "#$total: $param"
 
    total=$(($total + 1))
 
done

wdir=$PWD
outbeds=$wdir/bed_files/
outtrain=$wdir/training/

mkdir $outdir
mkdir $outbeds
mkdir $outtrain

cd $wdir
echo "getting training data for: "$name
sort -k7,7rn $peakfile  | head -n $topn | awk '{gsub("chr", "Chr", $1); print $1"\t"$2+$10-25"\t"$2+$10+25}' $peakfile  > $outbeds$name"_peak_regions_50bp.bed"
cat $outbeds$name"_peak_regions_50bp.bed" | sort -k1,1 -k2,2n | bedtools getfasta -tab -fi $genome -bed stdin | awk '{print $0"\t"1}' > $outdir$name"_50bp_top"$topn"_peakseqs_positive.txt"
cat $outbeds$name"_peak_regions_50bp.bed" | sort -k1,1 -k2,2n | bedtools shuffle -chrom -seed 421 -i stdin -g $chrsizes | bedtools getfasta -tab -fi $genome -bed stdin | awk '{print $0"\t"0}' > $outdir$name"_50bp_top"$topn"_peakseqs_negative.txt"
cat $outdir$name"_50bp_top"$topn"_peakseqs_negative.txt"  $outdir$name"_50bp_top"$topn"_peakseqs_positive.txt" >  $outtrain$name"_50bp_top"$topn"_peakseqs_labels.txt"
rm $outdir$name"_50bp_top"$topn"_peakseqs_negative.txt"
rm $outdir$name"_50bp_top"$topn"_peakseqs_positive.txt"

echo "finished...training data is in ./training/"




