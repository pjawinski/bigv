# ========================
# === plot power curve ===
# ========================

# set working directory
setwd('/Users/philippe/desktop/projects/bigv_arousal')

# activate R environment
if (exists('.rs.restartR', mode = 'function')) { .rs.restartR() }
source('renv/activate.R')
renv::restore(prompt = FALSE)

# attach packages to current R session
library(pwr)
library(scales)

# create function for power calculations
pwrcurve = function(n, lowerlimit, upperlimit, steps, thresh, alternative) {
  xy = cbind(NULL, NULL)       
  for (i in seq(lowerlimit, upperlimit, length.out = (upperlimit-lowerlimit)*steps+1)){
    calc = pwr.r.test(n = n, r = i, sig.level = thresh, power = NULL, alternative = alternative)
    xy = rbind(xy, cbind(calc$r, calc$power))
  }
  xy = data.frame(xy)
  colnames(xy) = c("r","power")
  xy
}

# settings
n = 468
ntests = 15
thresh = 0.05
threshcorr = 1-(1-thresh)^(1/ntests)
lowerlimit = 0
upperlimit = 0.4
steps = 10000
alternative = 'two.sided'

# create power curve for uncorrected and corrected threshold of significance
uncorr = pwrcurve(n, lowerlimit, upperlimit, steps, thresh, alternative)
corr = pwrcurve(n, lowerlimit, upperlimit, steps, threshcorr, alternative)

# set xlim and x-axis ticks
xlim = c(lowerlimit,upperlimit)
xticks = seq(lowerlimit,upperlimit,0.1)

# save as pdf and png
dir.create('code/figures')
for (img in c('pdf', 'png')) {
  
  if (img == 'pdf') { 
    pdf(file = 'code/figures/power.pdf', width=10/2.54, height=12/2.54)
  } else {
    png(filename = 'code/figures/power.png', width=10/2.54, height=12/2.54, units = "in", res = 600)
  }
  
  par(mgp = c(2, 0.7, 0), lwd=0.5)
  plot(uncorr$r,uncorr$power,
       type="n",
       main="", 
       ylab=expression(paste("1-", beta)),
       xlab="",
       pch=20,
       cex.lab=0.9,
       col="royalblue3",
       xlim=xlim,
       ylim=c(0,1),
       las=1,
       axes=FALSE)
  
  # Insert lines
  lines(uncorr$r, uncorr$power, col="royalblue3", type="l", lty=2)
  lines(corr$r, corr$power, col="royalblue3")

  # Adjust axis
  axis(side=2, at=seq(0,1,0.1), labels=seq(0,1,0.1), las=1, tck=-0.02, cex.axis=0.75, lwd=0.75)
  par(mgp = c(1, 0.3, 0))
  axis(side=1, at=xticks, labels=xticks, las=1, tck=-0.02, cex.axis=0.75, lwd=0.75)
  
  # X-axis title
  mtext(expression(paste("Spearman ", rho)), side=1, line=1.5, cex=0.9)
  
  # Insert dots at 20/50/80% Power
  doty = c(0.2,0.5,0.8)
  for (i in 1:3){
    dotx = pwr.r.test(n = n, r = NULL, sig.level = threshcorr, power = doty[i], alternative = alternative)$r
    text(x = dotx, y = doty[i], labels = bquote(paste("1-", beta," = ", .(doty[i]), ", ", rho, " = ", .(format(round(dotx,digits=3),nsmall=3)))), cex=0.6, pos=4)
    points(x = dotx, y = doty[i], pch=16, col="royalblue3", cex = 0.5)
  }
  
  # Finish plot
  dev.off()
}
