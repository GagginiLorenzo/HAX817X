#initialisation
library(plyr)
rho=c("rho_0/","rho_0,2/","rho_0,5/","rho_0,8/")
supposed_rho=c(0,0.2,0.5,0.8)

# Fonction critère de test, vérifie si la moyenne d'une matrice de correlation
# entre 2 groupe est contenue dans un intervalle autour de la valeur attendue

extern <- function(n=matrix(),supposed_mean=0)
{
  res = TRUE
  if ((mean(n) > supposed_mean + 0.04) || (mean(n) < supposed_mean - 0.04))
  {
    res= FALSE
  }
  returnValue(res)
}

# Pour chaque rho,on parcourt les 100 simulations

for (rho_index in 1:length(rho))
  { rhotype=rho[rho_index]
    rhovalue=supposed_rho[rho_index]
    print(rhotype)
    print(rhovalue)
    result=data.frame()
    for (i in 1:100)
    { # Pour chaque simulation, on génère Blocks la liste des 10 groupes associés
      extern_rho_is_valid = data.frame()
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

      for (group in 1:length(Blocks))
        {
        # Pour chaqu'un de ces groupes, on génère la liste des matrices de correlation avec chaqu'un des autres groupes
        extern_rho_for_group = lapply(Blocks[-group], cor, Blocks[[group]])
        #On teste chaque matrice de cette liste avec la fonction criter de test
        extern_rho_is_valid_for_group = lapply(extern_rho_for_group, extern, rhovalue)
        #On stack chaque test dans le dataframe, en préservant le bon format via rbind.fill de plyr
        extern_rho_is_valid = rbind.fill(extern_rho_is_valid, as.data.frame(extern_rho_is_valid_for_group))
        }
      result=rbind(result,as.vector(extern_rho_is_valid))
    }
    result<-result[,c(10,1,2,3,4,5,6,7,8,9)] # b1 au début + joli
    write.table(result,file=paste(rhotype,"extern_rho_test","csv",sep='.'),row.names=FALSE,sep = ",")
  }

