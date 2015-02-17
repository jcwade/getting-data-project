library(tools)

dataset.zip <- "UCI HAR Dataset.zip"
tidy.file <- "uci-har-tidy.txt"
averages.file <- "uci-har-averages.txt"

dataset.dir <- file_path_sans_ext(dataset.zip)
if (!file.exists(dataset.dir)) {
        unzip(dataset.zip)
}

get.features <- function() {
        path <- file.path(dataset.dir, "features.txt")
        tab <- read.table(path)

        # Make R-friendly column names using underscores.
        f <- tab$V2
        f <- gsub("\\(\\)", "_", f)
        f <- gsub("[(),-]", "_", f)

        # Remove multiple and trailing separators.
        f <- gsub("_+", "_", f)
        f <- gsub("_$", "", f)

        # Sanity check: no new duplicates.
        if (length(unique(f)) != length(unique(tab$V2))) {
                stop("Renaming caused new duplicate names.")
        }

        f
}

features <- get.features()

get.activity.labels <- function () {
        path <- file.path(dataset.dir, "activity_labels.txt")
        tab <- read.table(path)
        acts <- tab[, 2]

        # Use order given in file, not alphabetical.
        factor(acts, levels=acts, ordered=T)
}

activity.labels <- get.activity.labels()

read.one.dataset <- function(dataset) {
        read.it <- function(name) {
                f <- paste(name, "_", dataset, ".txt", sep="")
                p <- file.path(dataset.dir, dataset, f)
                read.table(p)
        }

        subjs <- read.it("subject")
        acts  <- read.it("y")
        feats <- read.it("X")
        data <- cbind(subjs, acts, feats)

        names(data) <- c("subject", "activity", features)
        rename.activities <- function(i) activity.labels[i]
        data$activity <- sapply(data$activity, rename.activities)

        data
}

extract.mean.and.std <- function(f) {
        m <- grepl("_mean(_|$)", names(f))
        s <- grepl("_std(_|$)", names(f))
        keep <- m | s
        keep[1:2] <- TRUE # subject & activity
        f[, keep]
}

average.by.activity.and.subject <- function(f) {
        avgs <- aggregate(f[3:ncol(f)], by=f[1:2], FUN=mean)
        avgs[order(avgs$subject, avgs$activity), ]
}

main <- function() {
        training <- read.one.dataset("train")
        test <- read.one.dataset("test")
        combined <- rbind(training, test)
        tidy <- extract.mean.and.std(combined)
        avgs <- average.by.activity.and.subject(tidy)

        write.table(tidy, tidy.file, row.names=FALSE)
        write.table(avgs, averages.file, row.names=FALSE)

        list(tidy=tidy, avgs=avgs)
}

if (!interactive()) {
        invisible(main())
}
