# Getting and Cleaning Data Course Project

This repo contains the scripts and documentation for the Getting and
Cleaning Data course project.

## Getting started

Place the file "UCI HAR Dataset.zip" in the same directory as the
"run_analysis.R" script.

Use R batch mode to run "run_analysis.R" at a command shell:

	$ R CMD BATCH run_analysis.R

This will produce two files, "uci-har-tidy.txt" and
"uci-har-averages.txt".  (A standard file called "run_analysis.Rout"
is also produced by R and can be ignored.)

The file "uci-har-tidy.txt" has the tidy dataset with subjects,
activities, and mean() and std() features.  The file
"uci-har-summary.txt" has the same features but aggregated by subject
and activity.  See "CodeBook.md" for a full description of the
datasets.
