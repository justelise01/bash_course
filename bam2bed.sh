#!/bin/env bash

#input variables
input_file=$1  #first argument is the input file
output_directory_user=$2 #second argument is the output directory provided by the user

#create output directory
mkdir --parent $output_directory_user 

#create and activate a conda environment with bedtools in it
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh
mamba create --name bam2bed bedtools #create environment
mamba activate bam2bed   #activate environment

#converting .bam file to .bed file
output_file=$output_directory_user/$(basename -s .bam $input_file).bed #important: includes filepath 
bedtools bamtobed -i $input_file >  $output_file

#subsetting .bed file to only contain chromosome 1
output_file_chr1=$output_directory_user/$(basename -s .bam $input_file)_chr1.bed
grep -P "Chr1([^0-9])" $output_file > $output_file_chr1 #make sure that there is no number behind the chr1 (prevent e.g. chr10 from also being included)
 

#counting lines of subset .bedfile
wc -l $output_file_chr1 > $output_directory_user/bam2bed_number_of_rows.txt


#variables
echo  Elise ten Kate

