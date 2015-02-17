# Getting and Cleaning Data Course Project

This repo contains the scripts and documentation for the Getting and
Cleaning Data course project.

## Getting started

Place the file "UCI HAR Dataset.zip" in the same directory as the
"run_analysis.R" script.

Use R batch mode to run "run_analysis.R" at a command shell:

	$ R CMD BATCH run_analysis.R

This will produce the file "uci-har-averages.txt", which contains the
feature summaries.  See "CodeBook.md" for a full description of this
dataset.

A standard file called "run_analysis.Rout" is also produced by R and
can be ignored.

In an interactive R session, calling the `run.analysis` function will
run the analysis, write the output, then return both tidy datasets in
a list.
