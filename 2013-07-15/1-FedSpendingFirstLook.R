# First look at update USAspending.gov files from recent download.
# Earl F Glynn, 17 March 2014

setwd("E:/FOIA/Federal-Spending/Archives/2013-07-15/")    ##### 1 of 1

sink("1-FedSpendingFirstLook.txt", split=TRUE)

time.1 <- Sys.time()

DATAFEEDS <- "datafeeds"
files <- list.files(path=DATAFEEDS)                 # All CSV files

splits <- strsplit(files, "_")                      # tokenize filenames
YEARS <- sort(unique( unlist(lapply(splits, "[", 1))  ))  # first token
TYPE  <- sort(unique( unlist(lapply(splits, "[", 3))  ))  # third token

Count.Fields  <- data.frame(matrix(0,length(YEARS), length(TYPE)))
names(Count.Fields)     <- TYPE
row.names(Count.Fields) <- YEARS

Count.Records <- Count.Fields

for (i in 1:length(TYPE))
{
  files <- list.files(path=DATAFEEDS, pattern=TYPE[i])

  splits <- strsplit(files, "_")
  file.year <- unlist(lapply(splits, "[", 1))

  print(TYPE[i])
  for (j in 1:length(files))
  {
    print(files[j])
    filename <- paste0(DATAFEEDS, "/", files[j])
    flush.console()
    counts <- count.fields(filename, sep=",", quote='"', skip=1,
                           blank.lines.skip=FALSE, comment.char="")
    # Skip loan (or other) files that are missing
    if (length(counts) > 0)
    {
      Count.Records[file.year[j], TYPE[i]] <- length(counts)
      x <- sort(table(counts), decreasing=TRUE)
      Count.Fields[file.year[j], TYPE[i]] <- as.integer(names(x)[1])
      if (length(x) > 1)
      {
        cat("Parsing problem\n")
        cat("TYPE: ", TYPE[i], ", FILE: ", files[j], "\n")
        print(x)
      }
    }
  }
}

Count.Records <- rbind(Count.Records, apply(Count.Records, 2, sum))
rownames(Count.Records)[nrow(Count.Records)] <- "TOTAL"

print("RECORDS")
Count.Records

print("FIELDS")
Count.Fields

write.csv(Count.Records, "FedSpending-RecordCounts.csv")
write.csv(Count.Fields,  "FedSpending-FieldCounts.csv")

time.2 <- Sys.time()
cat(sprintf(" %.1f", as.numeric(difftime(time.2, time.1,  units="secs"))), " secs\n")

sink()

