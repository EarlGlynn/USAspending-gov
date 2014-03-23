# Look at differences between Record Counts in July 2013 and March 2014.
# Earl F Glynn, 22 March 2014

setwd("E:/FOIA/Federal-Spending/Archives/")

OLD <- "2013-07-15"     ##### 1 of 5
NEW <- "2014-03-16"     ##### 2 of 5

d1 <- read.csv(paste0(OLD, "/FedSpending-RecordCounts.csv"), as.is=TRUE)
names(d1)[1] <- "FiscalYear"
d1$FiscalYear <- as.integer(d1$FiscalYear)
d1 <- d1[-nrow(d1),]  # get rid of total row
str(d1)
d1[15,] <- c(2014, rep(0,6))   ##### 3 of 5
d1

d2 <- read.csv(paste0(NEW, "/FedSpending-RecordCounts.csv"), as.is=TRUE)
names(d2)[1] <- "FiscalYear"
d2$FiscalYear <- as.integer(d2$FiscalYear)
d2 <- d2[-nrow(d2),]  # get rid of total row
str(d2)
d2 <- rbind(d1[1:3,], d2)      ##### 4 of 5

Diffs <- d2 - d1
Diffs$FiscalYear <- d2$FiscalYear

Diffs
write.csv(Diffs, "FedSpending-RecordCounts-Diffs.csv", row.names=FALSE)

show.presidential.terms <- function()
{
  xstart <- 1.3
  xdelta <- 4*1.2
  abline(v=xstart,          col="gray", lwd=3, lty="dotted")
  abline(v=xstart+  xdelta, col="gray", lwd=3, lty="dotted")
  abline(v=xstart+2*xdelta, col="gray", lwd=3, lty="dotted")
  abline(v=xstart+3*xdelta, col="gray", lwd=3, lty="dotted")
  invisible(0)
}

### Plots
windows(6, 10)

reset.par <- par(mfrow=c(6,1), mar=c(2,4,1,2), oma=c(2,0,2,0))

barplot(d2$Contracts[-nrow(d2)]/1E6, names.arg=d2$FiscalYear[-nrow(d2)],
        ylab="Contracts [millions]", las=1)
grid(nx=NA, ny=NULL)
show.presidential.terms()
mtext(expression(bold("Contracts")), adj=0.15, col="blue", line=-2.5)

mtext(expression(bold("USAspending.gov Records by Type of Spending by Fiscal Year")),
      outer=TRUE, col="blue")

barplot(d2$DirectPayments[-nrow(d2)]/1E6, names.arg=d2$FiscalYear[-nrow(d2)],
        ylab="Direct Payments [million]", las=1)
grid(nx=NA, ny=NULL)
show.presidential.terms()
mtext(expression(bold("Direct Payments")), adj=0.15, col="blue", line=-2.7)

barplot(d2$Grants[-nrow(d2)]/1E3, names.arg=d2$FiscalYear[-nrow(d2)],
        ylab="Grants [thousand]", las=1)
grid(nx=NA, ny=NULL)
show.presidential.terms()
mtext(expression(bold("Grants")), adj=0.125, col="blue", line=-1.7)

barplot(d2$Insurance[-nrow(d2)]/1E3, names.arg=d2$FiscalYear[-nrow(d2)],
        ylab="Insurance [thousand]", las=1)
grid(nx=NA, ny=NULL)
show.presidential.terms()
mtext(expression(bold("Insurance")), adj=0.15, col="blue", line=-3.2)

barplot(d2$Loans[-nrow(d2)]/1E6, names.arg=d2$FiscalYear[-nrow(d2)],
        ylab="Loans [million]", las=1)
grid(nx=NA, ny=NULL)
show.presidential.terms()
mtext(expression(bold("Loans")), adj=0.15, col="blue", line=-1.6)

barplot(d2$Others[-nrow(d2)]/1E3, names.arg=d2$FiscalYear[-nrow(d2)],
        ylab="Others [thousand]", las=1)
grid(nx=NA, ny=NULL)
show.presidential.terms()
mtext(expression(bold("Other")), adj=0.15, col="blue", line=-2.2)

mtext("  Source: www.USAspending.gov/data, 15 July 2013 (2000-2002), 16 March 2014 (2003-2013)",   ##### 5 of 5
      BOTTOM<-1, adj=0.05, line=0.5, cex=0.75, col="blue", outer=TRUE)
text(par()$usr[2]-0.25, par()$usr[3], expression(italic("WatchdogLabs.org  ")),
     adj=0, srt=90,  col="blue", cex=1.5, xpd=NA)   # No clipping

par(reset.par)

