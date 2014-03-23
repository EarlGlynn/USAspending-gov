Inventory of USAspending.gov Data
=================================

Location of Archive Files
-------------------------

**Start here**:  http://www.usaspending.gov/data  
**Select**: _Archives_ tab  

I normally search for _All Agencies_ for a specific fiscal year (2000-2014) and spending type (Contracts, Direct Payments, Grants, Insurance, Loans, Other).

Files are normally updated near the middle of the month.  While most additions and updates are for the most recent fiscal year, a number of changes are made to fiscal years sometimes back to the beginning of the archive.

The Archives have complete files and incremental files with changes made during the last month.  The goal is to analyze the monthly incremental files, but for now I'm studying the "big picture" using the complete files captured every few months.

In recent months, files from 2003 to 2014 have some updates every month.  As recently as July 2013, all files back to 2000 were updated.

My original intent was to obtain 10 years of data to look a trends, but when I found the data archive only went back to 2000, I decided to grab and study all years of data.

Scripts
-------

A pattern in the filenames makes writing a script to download the files fairly easy.

Studying the filenames on the Archives tab reveals the pattern.  For example, the file with FY 2014 Contracts data is:

    2014_All_Contracts_Full_20140316.csv.zip  

The filename pattern can be deduced to be:

    <fiscalyear>_All_<spendingtype>_Full_<releasedate>.csv.zip 

with _fiscalyear_ ranging from 2000 to 2014, _spendingtype_ one of the six spending types, and _releasedate_ in the format YYYYMMDD, which is usually near the middle of the month.  

Each of the downloads below have slightly different versions of these scripts. Look for comments like _##### m of n_ along the right margin of the R scripts to identify lines that possibly need to be changed with a new update.

The scripts must often be restarted to get around a variety of problems in the data or with the Internet connection. The goal is to develop a script that is a defined and repeatable process for working with the data.

**0-graball.R**  

Downloading the current release of all files results in about 11 GB of .zip files that expand into about 72 GB of .csv raw data files. The complete files with changed records had a total of over 62 million records.

The script records md5sums for all .zip and .csv files to determine easily if files have changed from the past.

I run the script only during late evening or early morning hours when the server likely has extra capacity.  The download time for me is about 6 hours, but that time can vary considerably.

**1-FedSpendingFirstLook.R**  

The "first look" uses R's _count.fields_ function to verify that all records in a file have the same number of fields in each line.  The script writes two summary files showing the number of fields and number of records in each file.

The script for the current release takes over 2 hours.

The parsing check was added after encountering a number of problems in past downloads because of poor data quality.  The run from March 16 shows a possible problem in parsing the 2011 Loans data.  This has not yet been investigated. 


16 March 2014 Download
----------------------

An R script can be used to download archive data for a specified set of years and spending types.  

Data for 2003-2014


```r
d1 <- read.csv("2014-03-16/FedSpending-RecordCounts.csv")
names(d1)[1] <- "FiscalYear"
```



```r
library(xtable)
xd1 <- xtable(d1, digits = 0)
print(xd1, format.args = list(big.mark = ","), type = "html")
```

<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Mar 23 15:57:40 2014 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> FiscalYear </TH> <TH> Contracts </TH> <TH> DirectPayments </TH> <TH> Grants </TH> <TH> Insurance </TH> <TH> Loans </TH> <TH> Others </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> 2003 </TD> <TD align="right"> 1,183,739 </TD> <TD align="right"> 588,868 </TD> <TD align="right"> 714,741 </TD> <TD align="right"> 14,734 </TD> <TD align="right"> 0 </TD> <TD align="right"> 1,359 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> 2004 </TD> <TD align="right"> 2,001,677 </TD> <TD align="right"> 578,146 </TD> <TD align="right"> 746,182 </TD> <TD align="right"> 14,895 </TD> <TD align="right"> 0 </TD> <TD align="right"> 724 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> 2005 </TD> <TD align="right"> 2,921,828 </TD> <TD align="right"> 493,433 </TD> <TD align="right"> 708,084 </TD> <TD align="right"> 14,456 </TD> <TD align="right"> 0 </TD> <TD align="right"> 1,609 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> 2006 </TD> <TD align="right"> 3,795,532 </TD> <TD align="right"> 658,747 </TD> <TD align="right"> 482,701 </TD> <TD align="right"> 14,516 </TD> <TD align="right"> 0 </TD> <TD align="right"> 161 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> 2007 </TD> <TD align="right"> 4,110,469 </TD> <TD align="right"> 292,406 </TD> <TD align="right"> 379,270 </TD> <TD align="right"> 11,109 </TD> <TD align="right"> 230,058 </TD> <TD align="right"> 3,024 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> 2008 </TD> <TD align="right"> 4,503,746 </TD> <TD align="right"> 1,050,682 </TD> <TD align="right"> 395,640 </TD> <TD align="right"> 12,095 </TD> <TD align="right"> 220,531 </TD> <TD align="right"> 5,028 </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> 2009 </TD> <TD align="right"> 3,493,168 </TD> <TD align="right"> 1,542,045 </TD> <TD align="right"> 580,429 </TD> <TD align="right"> 18,512 </TD> <TD align="right"> 416,629 </TD> <TD align="right"> 3,835 </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> 2010 </TD> <TD align="right"> 3,531,404 </TD> <TD align="right"> 2,902,512 </TD> <TD align="right"> 654,930 </TD> <TD align="right"> 21,724 </TD> <TD align="right"> 970,503 </TD> <TD align="right"> 17,785 </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> 2011 </TD> <TD align="right"> 3,383,438 </TD> <TD align="right"> 2,505,670 </TD> <TD align="right"> 543,568 </TD> <TD align="right"> 84,009 </TD> <TD align="right"> 1,252,483 </TD> <TD align="right"> 45,208 </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> 2012 </TD> <TD align="right"> 3,100,519 </TD> <TD align="right"> 2,155,291 </TD> <TD align="right"> 512,335 </TD> <TD align="right"> 90,864 </TD> <TD align="right"> 320,795 </TD> <TD align="right"> 83,863 </TD> </TR>
  <TR> <TD align="right"> 11 </TD> <TD> 2013 </TD> <TD align="right"> 2,480,526 </TD> <TD align="right"> 2,142,292 </TD> <TD align="right"> 557,882 </TD> <TD align="right"> 99,110 </TD> <TD align="right"> 259,712 </TD> <TD align="right"> 68,178 </TD> </TR>
  <TR> <TD align="right"> 12 </TD> <TD> 2014 </TD> <TD align="right"> 597,330 </TD> <TD align="right"> 1,152,954 </TD> <TD align="right"> 152,964 </TD> <TD align="right"> 49,918 </TD> <TD align="right"> 121,851 </TD> <TD align="right"> 26,047 </TD> </TR>
  <TR> <TD align="right"> 13 </TD> <TD> TOTAL </TD> <TD align="right"> 35,103,376 </TD> <TD align="right"> 16,063,046 </TD> <TD align="right"> 6,428,726 </TD> <TD align="right"> 445,942 </TD> <TD align="right"> 3,792,562 </TD> <TD align="right"> 256,821 </TD> </TR>
   </TABLE>



15 July 2013 Download
---------------------

Data for 2000-2013 -- the last time Fiscal Years 2000-2002 were updated. 


```r
d2 <- read.csv("2013-07-15/FedSpending-RecordCounts.csv")
names(d2)[1] <- "FiscalYear"
```



```r
xd2 <- xtable(d2, digits = 0)
print(xd2, format.args = list(big.mark = ","), type = "html")
```

<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Mar 23 15:57:40 2014 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> FiscalYear </TH> <TH> Contracts </TH> <TH> DirectPayments </TH> <TH> Grants </TH> <TH> Insurance </TH> <TH> Loans </TH> <TH> Others </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> 2000 </TD> <TD align="right"> 594,426 </TD> <TD align="right"> 486,313 </TD> <TD align="right"> 552,428 </TD> <TD align="right"> 20,359 </TD> <TD align="right"> 0 </TD> <TD align="right"> 729 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> 2001 </TD> <TD align="right"> 641,840 </TD> <TD align="right"> 573,818 </TD> <TD align="right"> 549,379 </TD> <TD align="right"> 16,833 </TD> <TD align="right"> 1 </TD> <TD align="right"> 295 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> 2002 </TD> <TD align="right"> 830,363 </TD> <TD align="right"> 532,286 </TD> <TD align="right"> 591,117 </TD> <TD align="right"> 15,325 </TD> <TD align="right"> 0 </TD> <TD align="right"> 2,593 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> 2003 </TD> <TD align="right"> 1,183,512 </TD> <TD align="right"> 588,868 </TD> <TD align="right"> 714,729 </TD> <TD align="right"> 14,734 </TD> <TD align="right"> 0 </TD> <TD align="right"> 1,359 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> 2004 </TD> <TD align="right"> 2,001,477 </TD> <TD align="right"> 578,146 </TD> <TD align="right"> 746,136 </TD> <TD align="right"> 14,895 </TD> <TD align="right"> 0 </TD> <TD align="right"> 724 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> 2005 </TD> <TD align="right"> 2,921,547 </TD> <TD align="right"> 493,433 </TD> <TD align="right"> 708,042 </TD> <TD align="right"> 14,456 </TD> <TD align="right"> 0 </TD> <TD align="right"> 1,609 </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> 2006 </TD> <TD align="right"> 3,795,297 </TD> <TD align="right"> 658,747 </TD> <TD align="right"> 482,618 </TD> <TD align="right"> 14,516 </TD> <TD align="right"> 0 </TD> <TD align="right"> 161 </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> 2007 </TD> <TD align="right"> 4,110,093 </TD> <TD align="right"> 292,416 </TD> <TD align="right"> 379,059 </TD> <TD align="right"> 11,109 </TD> <TD align="right"> 230,050 </TD> <TD align="right"> 3,024 </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> 2008 </TD> <TD align="right"> 4,501,806 </TD> <TD align="right"> 1,050,641 </TD> <TD align="right"> 394,974 </TD> <TD align="right"> 12,095 </TD> <TD align="right"> 220,508 </TD> <TD align="right"> 5,025 </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> 2009 </TD> <TD align="right"> 3,491,122 </TD> <TD align="right"> 1,542,020 </TD> <TD align="right"> 579,687 </TD> <TD align="right"> 18,512 </TD> <TD align="right"> 416,614 </TD> <TD align="right"> 3,835 </TD> </TR>
  <TR> <TD align="right"> 11 </TD> <TD> 2010 </TD> <TD align="right"> 3,531,586 </TD> <TD align="right"> 2,902,484 </TD> <TD align="right"> 651,679 </TD> <TD align="right"> 21,724 </TD> <TD align="right"> 970,530 </TD> <TD align="right"> 17,785 </TD> </TR>
  <TR> <TD align="right"> 12 </TD> <TD> 2011 </TD> <TD align="right"> 3,381,808 </TD> <TD align="right"> 2,505,691 </TD> <TD align="right"> 539,568 </TD> <TD align="right"> 84,007 </TD> <TD align="right"> 1,255,491 </TD> <TD align="right"> 45,206 </TD> </TR>
  <TR> <TD align="right"> 13 </TD> <TD> 2012 </TD> <TD align="right"> 3,092,747 </TD> <TD align="right"> 2,177,933 </TD> <TD align="right"> 511,077 </TD> <TD align="right"> 90,862 </TD> <TD align="right"> 323,030 </TD> <TD align="right"> 83,858 </TD> </TR>
  <TR> <TD align="right"> 14 </TD> <TD> 2013 </TD> <TD align="right"> 1,398,174 </TD> <TD align="right"> 1,703,244 </TD> <TD align="right"> 338,248 </TD> <TD align="right"> 66,144 </TD> <TD align="right"> 188,960 </TD> <TD align="right"> 33,224 </TD> </TR>
  <TR> <TD align="right"> 15 </TD> <TD> TOTAL </TD> <TD align="right"> 35,475,798 </TD> <TD align="right"> 16,086,040 </TD> <TD align="right"> 7,738,741 </TD> <TD align="right"> 415,571 </TD> <TD align="right"> 3,605,184 </TD> <TD align="right"> 199,427 </TD> </TR>
   </TABLE>


Change from July 2013 to March 2014
-----------------------------------

We need to modify both data.frames to have the same year rows:


```r
d1 <- d1[-nrow(d1), ]
d1 <- rbind(d2[1:3, ], d1)

d2 <- d2[-nrow(d2), ]  # get rid of total row  
d2[15, ] <- c(2014, rep(0, 6))  # add zeroes for 2014
```

```
## Warning: invalid factor level, NA generated
```

```r

Diffs <- d1 - d2
```

```
## Warning: - not meaningful for factors
```

```r
Diffs$FiscalYear <- d1$FiscalYear
```


This table shows the changes in the number of records by fiscal year by type of spending from July 15, 2013 to March 16, 2014 in USAspending.gov:


```r
xDiffs <- xtable(Diffs, digits = 0)
print(xDiffs, format.args = list(big.mark = ","), type = "html")
```

<!-- html table generated in R 3.0.2 by xtable 1.7-3 package -->
<!-- Sun Mar 23 15:57:40 2014 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> FiscalYear </TH> <TH> Contracts </TH> <TH> DirectPayments </TH> <TH> Grants </TH> <TH> Insurance </TH> <TH> Loans </TH> <TH> Others </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> 2000 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> 2001 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> 2002 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> 2003 </TD> <TD align="right"> 227 </TD> <TD align="right"> 0 </TD> <TD align="right"> 12 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> 2004 </TD> <TD align="right"> 200 </TD> <TD align="right"> 0 </TD> <TD align="right"> 46 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> 2005 </TD> <TD align="right"> 281 </TD> <TD align="right"> 0 </TD> <TD align="right"> 42 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> 2006 </TD> <TD align="right"> 235 </TD> <TD align="right"> 0 </TD> <TD align="right"> 83 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> 2007 </TD> <TD align="right"> 376 </TD> <TD align="right"> -10 </TD> <TD align="right"> 211 </TD> <TD align="right"> 0 </TD> <TD align="right"> 8 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> 2008 </TD> <TD align="right"> 1,940 </TD> <TD align="right"> 41 </TD> <TD align="right"> 666 </TD> <TD align="right"> 0 </TD> <TD align="right"> 23 </TD> <TD align="right"> 3 </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> 2009 </TD> <TD align="right"> 2,046 </TD> <TD align="right"> 25 </TD> <TD align="right"> 742 </TD> <TD align="right"> 0 </TD> <TD align="right"> 15 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 11 </TD> <TD> 2010 </TD> <TD align="right"> -182 </TD> <TD align="right"> 28 </TD> <TD align="right"> 3,251 </TD> <TD align="right"> 0 </TD> <TD align="right"> -27 </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD align="right"> 12 </TD> <TD> 2011 </TD> <TD align="right"> 1,630 </TD> <TD align="right"> -21 </TD> <TD align="right"> 4,000 </TD> <TD align="right"> 2 </TD> <TD align="right"> -3,008 </TD> <TD align="right"> 2 </TD> </TR>
  <TR> <TD align="right"> 13 </TD> <TD> 2012 </TD> <TD align="right"> 7,772 </TD> <TD align="right"> -22,642 </TD> <TD align="right"> 1,258 </TD> <TD align="right"> 2 </TD> <TD align="right"> -2,235 </TD> <TD align="right"> 5 </TD> </TR>
  <TR> <TD align="right"> 14 </TD> <TD> 2013 </TD> <TD align="right"> 1,082,352 </TD> <TD align="right"> 439,048 </TD> <TD align="right"> 219,634 </TD> <TD align="right"> 32,966 </TD> <TD align="right"> 70,752 </TD> <TD align="right"> 34,954 </TD> </TR>
  <TR> <TD align="right"> 15 </TD> <TD> 2014 </TD> <TD align="right"> 597,330 </TD> <TD align="right"> 1,152,954 </TD> <TD align="right"> 152,964 </TD> <TD align="right"> 49,918 </TD> <TD align="right"> 121,851 </TD> <TD align="right"> 26,047 </TD> </TR>
   </TABLE>


Observations:  

1. The number of records for all spending types has not changed for fiscal years 2000 to 2002 since July 2013.
2. The reason for a net decrease in certain records is unclear, e.g., 22,642 fewer DirectPayments in FY 2012, or over 5000 fewer loans in FY 2011 and FY 2012.
3. The reason for changes in past fiscal years more than a few years back is unclear.  There were hundreds of changes in contract records for FY 2003 to 2007, and with the exception of 2010, there were thousands of changes for FY 2008 to 2012 in contract counts.
4. A chart of the changes by spending type by month might be interesting.
5. It's unclear what changes will be happening in the next few months due to the [OMB mandate to improve data quality in USAspending.gov](http://www.whitehouse.gov/sites/default/files/omb/financial/memos/improving-data-quality-for-usaspending-gov.pdf). 

WatchdogLabs.org Article
------------------------
[Inventory of USAspending.gov Data](http://watchdoglabs.org/), _WatchdogLabs.org_, March 23, 2014.
