library(MASS)
options(warn=-1)

data = read.table("question1.txt")
A = as.matrix(data)
row = nrow(A)
for(i in 1:(row-1))
{
for(j in (i+1):row)
{
cat("Wilcox and t-test results for Row ",i," and Row ",j)
B = wilcox.test(A[i,],A[j,],alternative = c("two.sided","less","greater"),mu=0,paired=TRUE,conf.int=FALSE,conf.level = 0.95)
print(B)
C = t.test(A[i,],A[j,],alternative = c("two.sided","less","greater"),mu = 0,paired = TRUE,var.equal = FALSE,conf.level = .95)
print(C)

}
}
#print(data)
#name <-c("Row 1","Row 2","Row 3")
#row.names(data) <- name
#print(A)
#boxplot(A[1,0],A[2,0],A[3,0])
boxplot(A[1,],A[2,],A[3,],range = 1.0,width = NULL,plot = TRUE,labels=FALSE, varwidth = FALSE,outline = TRUE,border = par("fg"))
labels <- paste(c("Row 1", 
                  "Row 2",
                  "Row 3"))
axis(1, labels = FALSE)
text(x =  seq_along(labels), y = par("usr")[3] - 1, srt = 45, adj = 1,
     labels = labels, xpd = TRUE)
