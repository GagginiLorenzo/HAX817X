rho=c("rho_0/","rho_0,2/","rho_0,5/","rho_0,8/")
intern <- function(n=matrix())
  {
  res = TRUE
  if (mean(n) > 0.84 || mean(n) < 0.76 ) 
    {
    res= FALSE
    }
  returnValue(res)
}

for (rhotype in rho)
  { result=data.frame()
  for (i in 1:100)
    {
      Data <- read.csv(file=paste(rhotype,as.character(i),".csv",sep=""),stringsAsFactors=TRUE)
      Variables=Data[-1]
      Blocks=list(b1=Variables[1:5],
                  b2=Variables[6:10],
                  b3=Variables[11:15],
                  b4=Variables[16:20],
                  b5=Variables[21:25],
                  b6=Variables[26:30],
                  b7=Variables[31:35],
                  b8=Variables[36:40],
                  b9=Variables[41:45],
                  b10=Variables[46:50])
      intern_rho = lapply(Blocks,cor)
      intern_rho_is_valid = lapply(intern_rho,intern )
      result=rbind(result,as.vector(intern_rho_is_valid))
      }
    write.table(result,file=paste(rhotype,"intern_rho_test","csv",sep='.'),row.names=FALSE,sep = ",")
    }
