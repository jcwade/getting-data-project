## UCI HAR dataset

The University of California at Irvine "Human Activity Recognition
Using Smartphones" dataset consists of smartphone telemetry data
collected while subjects performed various activities like walking and
standing.

See

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

for full details.

The data used for the present analysis was downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data were randomly partitioned into two sets, "train" and
"test".  In each dataset there are three data files:

1. X_{train, test}.txt: Observed numeric features.
2. y_{train, test}.txt: Integer labels for WALKING, etc.
3. subject_{train, test}.txt: Integer subjects identifiers.

## Tidy Dataset 1 ("uci-har-tidy.txt")

This dataset merges the train and test data and selects only the
mean() and std() features.

The resulting dataset has the following groups of columns:

* Col 1: Subject identifier.
* Col 2: Activity label.
* Cols 3 to 563: Features on mean() and std() measurements.

### Variables

The subject identifiers are the same as in the original data.  They
are integers from 1 to 30.

The activity labels ("WALKING", etc.) use the descriptive names from
"activity_labels.txt" instead of the integer values found in the
original data.

For features, we largely preserved the names found in "features.txt".

Names that included special characters in R such as `(`, `)`, `-`, and
`,` were transformed to use underscores.  For example:

- `tBodyAcc-mean()-X` to `tBodyAcc_mean_X`,
- `tBodyAcc-sma()` to `tBodyAcc_sma`,
- `angle(tBodyAccMean,gravity)` to `angle_tBodyAccMean_gravity`.

This change allows the names to be used without quoting.

Units are the same as the original data: accelerometer data ("Acc") is
in units of standard gravity 'g'; gyroscope (Gyro) data is in units of
radians per second.

### Steps

To create this dataset, the following operations were performed:

1. Extracted features and labeled them with normalized names from
   "features.txt".
2. Joined the subject, activity, and feature columns into one data
   frame.
3. Mapped integer activity values to descriptive factors found in
   "activity_labels.txt".
4. Joined "train" and "test" datasets.
5. Extracted mean() and std() features using regular expression
   searches for "mean" and "std", taking care to avoid any case where
   they might appear as a substring of another word (e.g., "mean" in
   "meaning").

## Tidy Dataset 2 ("uci-har-averages.txt")

This dataset computes mean values for the features according to
(subject, activity) pairs.  The analysis was performed using the first
dataset, not the original data.

This dataset uses the same column order and names as the first
dataset.  The feature values are means in groups defined by (subject,
activity) pairs.  The units are therefore the same as those in the
first dataset.

