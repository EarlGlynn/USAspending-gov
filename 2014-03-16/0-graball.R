# Grab all USASpending.gov federal spending archive data since 2003.
# Files prior to 2003 have not been updated since July 2013.

# Earl F Glynn, 16 March 2014.

# Start here:  http://www.usaspending.gov/data
# Select Archives tab.
# Look for latest "Date As Of" and change DIRDATE below.           ##### 1 of 4

# To get current release date for data:  (roughly mid-month)
# 1. http://www.usaspending.gov/data
# 2. Archives

setwd("E:/FOIA/Federal-Spending/Archives/")                        ##### 2 of 4
sink("0-graball.txt", split=TRUE)

library(tools)  # md5sum

time.1 <- Sys.time()

BASE        <- "http://www.usaspending.gov/datafeeds/"
DIRDATE     <- "2014-03-16"            # yyyy-mm-dd format         ##### 3 of 4
FILEDATE    <-  gsub("-","",DIRDATE)   # yyyymmdd   format

# Grab all complete fiscal years and most recent incomplete year
FISCAL.YEAR <- 2014:2003    # Get more recent years first          ##### 4 of 4
TYPE        <- c("Contracts",      "Grants",    "Loans",
                 "DirectPayments", "Insurance", "Others")
SUFFIX      <- ".csv.zip"

ZIP.DIR <- paste0(DIRDATE, "/ZIP/")
if (! file.exists(ZIP.DIR))
{
  dir.create(ZIP.DIR, recursive=TRUE)
}

################################################################################
### Download ZIP files

for (type in TYPE)
{
  for (year in FISCAL.YEAR)
  {
    filename <- paste0(year, "_All_", type, "_Full_", FILEDATE, SUFFIX)
    cat(filename,"\n")
    try(
      download.file(paste0(BASE,filename),
                    destfile=paste0("./", ZIP.DIR, filename)),
      FALSE)
  }
}

PATTERN <- paste(".*\\.csv\\.zip$", sep="")
zip.files <- paste0(ZIP.DIR, list.files(path=ZIP.DIR, pattern=PATTERN))

md5sums <- data.frame(md5sum=md5sum(zip.files))
write.csv(md5sums, "md5sums-zip.csv")   # Record md5sums

info <- file.info(zip.files)
write.csv(info[,c("size", "mtime", "ctime", "atime")], "info-zip.csv")

################################################################################
### Expand ZIPs

CSV.DIR <- paste0(DIRDATE, "/datafeeds/") # ZIPs include files in this dir

spending.files <- NULL
for (i in 1:length(zip.files))
{
  info <- file.info(zip.files[i])
  # 0-length file in ZIP is 200 bytes, if ZIP exists
  if ( (!is.na(info$size)) & (info$size > 200) )  # skip zips with 0-length file
  {
    spending.files <- c(spending.files,
                        unzip(zip.files[i], exdir=DIRDATE))
  }
}
spending.files

if (length(spending.files) > 0)
{

  md5sums <- data.frame(md5sum=md5sum(spending.files))
  write.csv(md5sums, "md5sums-csv.csv")   # Record md5sums

  info <- file.info(spending.files)
  write.csv(info[,c("size", "mtime", "ctime", "atime")], "info-csv.csv")
}

time.2 <- Sys.time()
cat(sprintf(" %.1f", as.numeric(difftime(time.2, time.1,  units="secs"))), " secs\n")

sink()

