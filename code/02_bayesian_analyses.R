# ===================================================
# === Get Bayes Factors for Spearman Correlations ===
# ===================================================

# set working directory
setwd('/Users/philippe/Desktop/projects/bigv_arousal')

# activate R environment
source("renv/activate.R")
renv::restore(prompt = FALSE)

# attach packages to current R session
library(BayesFactor)
library(rstanarm)

# load data
NEO = read.delim('code/derivatives/01_bigv_arousal.txt', sep = '\t', header = TRUE)

# carry out bayesian correlations: NEO personality dimensions x EEG-vigilance
m = data.frame(matrix(NA, nrow = 5, ncol = 6))
names(m) = c('rho_Mean', 'rho_Stability', 'rho_Slope', 'BF_Mean', 'BF_Stability', 'BF_Slope')
row.names(m) = names(NEO[,c(10:14)])
 
set.seed(81231)
for (i in 1:5) {
  for (j in 1:3) {
    message(paste0('\n', i, '.', j, ' - ', names(NEO[i+9]), ' X ', names(NEO[j+6])))
    bfmodel = correlationBF(rank(NEO[,i+9]), rank(NEO[,j+6]), rscale = 'medium')
    samples = posterior(bfmodel, iterations = 1000000)
    m[i,j] = mean(samples[,"rho"])
    m[i,j+3] = extractBF(bfmodel)$bf
  }
}

# save results
write.table(m, file = 'code/tables/bf_bigv_full.txt', quote = FALSE, col.names = NA, sep = '\t')

# carry out bayesian correlations: NEO personality facets x EEG-vigilance
m = data.frame(matrix(NA, nrow = 30, ncol = 6))
names(m) = c('rho_Mean', 'rho_Stability', 'rho_Slope', 'BF_Mean', 'BF_Stability', 'BF_Slope')
row.names(m) = names(NEO[,c(15:44)])

set.seed(59210)
for (i in 1:30) {
  for (j in 1:3) {
    message(paste0('\n', i, '.', j, ' - ', names(NEO[i+14]), ' X ', names(NEO[j+6])))
    bfmodel = correlationBF(rank(NEO[,i+14]), rank(NEO[,j+6]), rscale = 'medium')
    samples = posterior(bfmodel, iterations = 1000000)
    m[i,j] = mean(samples[,"rho"])
    m[i,j+3] = extractBF(bfmodel)$bf
  }
}

# save results
write.table(m, file = 'code/tables/bf_facets_full.txt', quote = FALSE, col.names = NA, sep = '\t')

# carry out partial bayesian correlations: NEO personality dimensions x EEG-vigilance
m = data.frame(matrix(NA, nrow = 5, ncol = 6))
names(m) = c('rho_Mean', 'rho_Stability', 'rho_Slope', 'BF_Mean', 'BF_Stability', 'BF_Slope')
row.names(m) = names(NEO[,c(10:14)])

set.seed(70845)
for (i in 1:5) {
  for (j in 1:3) {
    message(paste0('\n', i, '.', j, ' - ', names(NEO[i+9]), ' X ', names(NEO[j+6])))
    data = data.frame(age = rank(NEO[,3]), sex = rank(NEO[,4]), daytime = rank(NEO[,5]), NEO = rank(NEO[,i+9]), EEG = rank(NEO[,j+6]))
    data$NEO = stan_glm(paste("NEO", "~", paste(c("1", names(data[1:3])), collapse = " + ")), data = data, refresh = 0, iter = 10000)$residuals
    data$EEG = stan_glm(paste("EEG", "~", paste(c("1", names(data[1:3])), collapse = " + ")), data = data, refresh = 0, iter = 10000)$residuals
    bfmodel = correlationBF(data$NEO, data$EEG, rscale = 'medium')
    samples = posterior(bfmodel, iterations = 1000000)
    m[i,j] = mean(samples[,"rho"])
    m[i,j+3] = extractBF(bfmodel)$bf
  }
}

# save results
write.table(m, file = 'code/tables/bf_bigv_partial.txt', quote = FALSE, col.names = NA, sep = '\t')

# carry out partial bayesian correlations: NEO personality facets x EEG-vigilance
m = data.frame(matrix(NA, nrow = 30, ncol = 6))
names(m) = c('rho_Mean', 'rho_Stability', 'rho_Slope', 'BF_Mean', 'BF_Stability', 'BF_Slope')
row.names(m) = names(NEO[,c(15:44)])

set.seed(42291)
for (i in 1:30) {
  for (j in 1:3) {
    message(paste0('\n', i, '.', j, ' - ', names(NEO[i+14]), ' X ', names(NEO[j+6])))
    data = data.frame(age = rank(NEO[,3]), sex = rank(NEO[,4]), daytime = rank(NEO[,5]), NEO = rank(NEO[,i+14]), EEG = rank(NEO[,j+6]))
    data$NEO = stan_glm(paste("NEO", "~", paste(c("1", names(data[1:3])), collapse = " + ")), data = data, refresh = 0, iter = 10000)$residuals
    data$EEG = stan_glm(paste("EEG", "~", paste(c("1", names(data[1:3])), collapse = " + ")), data = data, refresh = 0, iter = 10000)$residuals
    bfmodel = correlationBF(data$NEO, data$EEG, rscale = 'medium')
    samples = posterior(bfmodel, iterations = 1000000)
    m[i,j] = mean(samples[,"rho"])
    m[i,j+3] = extractBF(bfmodel)$bf
  }
}

# save results
write.table(m, file = 'code/tables/bf_facets_partial.txt', quote = FALSE, col.names = NA, sep = '\t')
