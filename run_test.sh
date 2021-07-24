#!/usr/bin/env bash
#
# Example docker command:
#
# docker run -it -v $(pwd)/INPUTS:/INPUTS <image_id> /INPUTS/test.html /INPUTS

html_file=$1
out_dir=$2

wkhtmltopdf ${html_file} ${out_dir}/output.pdf
