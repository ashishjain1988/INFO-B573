library(MASS)
options(warn=-1)
A = read.table("question1.txt")
#B = as.vector(A)
A = A*5
write.table(A, file = "result1.txt", sep = "\t",col.names = F, row.names = F)
print("Please see the resultant matrix stored in result1.txt in the current folder")
