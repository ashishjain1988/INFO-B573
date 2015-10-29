library(MASS)
options(warn=-1)
f <- read.delim("U00096.ptt",header=TRUE,skip=2,sep="\t")
head(f)
a<-f$Length
l<-max(a)
r<-(l%%100)
l<-l-r+100
bins<-seq(0,l,by=100)
xbins<-c(0,2500)
ylimit<-c(0,1500)
hist(a,breaks=bins,xlab="Length of Sequences", main = "Frequency Plot of Protein Sequences in Escherichia coli",col="gray",xlim=xbins,ylim=ylimit)



