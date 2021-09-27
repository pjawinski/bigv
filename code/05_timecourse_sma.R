# ==========================================================================================================
# == Calculate simple moving averages of EEG-vigilance classifications in order to plot EEG time-courses ===
# ==========================================================================================================
    
# set working directory
setwd('/users/philippe/desktop/projects/bigv_arousal')

# activate R environment
renv::activate()
renv::restore(prompt = FALSE)

# attach packages to current R session
library(data.table)
library(plyr)
library(stringr)

# import data (synthetic dataset at 'synthetic/vigall_classifications_synthetic.txt')
vigall = read.table('data/vigall_classifications.txt', header = T)

# transform from characters to numbers
vigall[] = lapply(vigall, as.character)
vigall[vigall=="W"]=7
vigall[vigall=="A1"]=6
vigall[vigall=="A2"]=5
vigall[vigall=="A3"]=4
vigall[vigall=="B1"]=3
vigall[vigall=="B23"]=2
vigall[vigall=="C"]=1

# substitute X in first column by the first valid classification
table(vigall[,2], useNA="ifany")
for (i in 1:length(vigall[,2])) {
  if (vigall[i,2]=="X") {
    for (j in 3:length(vigall)) {
      if (vigall[i,j]!="X") {
        vigall[i,2]=vigall[i,j]
        break
      }
    }
  }
}
table(vigall[,2], useNA="ifany")

# substitute X in other columns through last-observation-carried-forward procedure
for (i in 1:length(vigall[,2])) {
  for (j in 2:length(vigall)) {
    if (vigall[i,j]=="X") {
      vigall[i,j]=vigall[i,j-1]
    }
  }
  message("Finished participant ", i, " out of ", length(vigall[,2]), ".")
}

# calculate simple moving average (± 30)
vigall[,2:length(vigall)] = lapply(vigall[,2:length(vigall)], as.numeric)
vigall_sma = vigall

options(warn=-1)
for (i in 1:length(vigall[,2])) {
  for (j in 2:length(vigall)) {
  vigall_sma[i,j]=mean(data.matrix(vigall[i,c(max(2,j-30):min(j+30,length(vigall)))]), na.rm = T)
  }
  message("Finished participant ", i, " out of ", length(vigall[,2]), ".")
}
options(warn=0)

# write table
write.table(vigall_sma, file = 'code/derivatives/vigall_classifications_sma.txt', sep = "\t", quote = F, col.names = T, row.names = F)
