#!/bin/bash

export PATH=$HOME/:/opt/homebrew/bin:/usr/local/bin:/Library/TeX/texbin/:$PATH

if [ -z "$MARKED_ORIGIN" ]; then
    cd $MARKED_ORIGIN
else
	tmpfile=$(mktemp -d)
    cd $tmpfile
fi

cat $HOME/marked2script/header_yml.qmd > tempforstreamingpreview.qmd 
cat - >> tempforstreamingpreview.qmd

sed -i "" -e "s/\[\^[[:space:]]/\[\^/g" tempforstreamingpreview.qmd
sed -i "" -e "s/\.\.\///g" tempforstreamingpreview.qmd

Rscript --default-packages=dplyr,knitr,kableExtra,stats,datasets,graphics,grDevices -e "out_type <- 'html'" -e "rendered_output <- rmarkdown::render('tempforstreamingpreview.qmd', output_format = 'html_document',quiet=TRUE, output_options=list(title='PREVIEW'))" -e "cat(readLines(rendered_output), sep = '\n')" 

rm tempforstreamingpreview.qmd
