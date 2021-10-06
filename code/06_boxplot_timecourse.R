# ===============================================================================================
# == Draw time-courses of EEG-vigilance and boxplots for EEG-vigilance variable 'slope index' ===
# ===============================================================================================
    
# set working directory
setwd('/users/philippe/desktop/projects/bigv_arousal')

# activate R environment
if (exists('.rs.restartR', mode = 'function')) { .rs.restartR() }
source('renv/activate.R')
renv::restore(prompt = FALSE)

# attach packages to current R session
library(data.table)
library(ggplot2)
library(patchwork)
library(dplyr)

# load dataset (synthetic dataset at 'synthetic/01_bigv_arousal_synthetic.txt')
df = read.delim('code/derivatives/01_bigv_arousal.txt', sep='\t', header=T ,quote = "\"",stringsAsFactors=FALSE)
bigv = df[,c('SIC', 'VIGALL_DT3_214_EEG_Code','VIGALL_DT3_214_V_1_20', 'VIGALL_DT3_214_SI_20_5', 'VIGALL_DT3_214_V_LogSqR_adj',
             'NEO_N_T', 'NEO_E_T', 'NEO_O_T', 'NEO_A_T', 'NEO_C_T')]

# median split
setDT(bigv)[,NEO_N_T_mediansplit := cut(NEO_N_T, quantile(NEO_N_T, probs = seq(0,1,0.5)), labels = c('low', 'high'), include.lowest = TRUE)]
setDT(bigv)[,NEO_E_T_mediansplit := cut(NEO_E_T, quantile(NEO_E_T, probs = seq(0,1,0.5)), labels = c('low', 'high'), include.lowest = TRUE)]
setDT(bigv)[,NEO_O_T_mediansplit := cut(NEO_O_T, quantile(NEO_O_T, probs = seq(0,1,0.5)), labels = c('low', 'high'), include.lowest = TRUE)]
setDT(bigv)[,NEO_A_T_mediansplit := cut(NEO_A_T, quantile(NEO_A_T, probs = seq(0,1,0.5)), labels = c('low', 'high'), include.lowest = TRUE)]
setDT(bigv)[,NEO_C_T_mediansplit := cut(NEO_C_T, quantile(NEO_C_T, probs = seq(0,1,0.5)), labels = c('low', 'high'), include.lowest = TRUE)]

# load classifications
vigall_sma = read.delim('code/derivatives/vigall_classifications_sma.txt', sep = '\t', header = TRUE)
names(vigall_sma)[1] = "VIGALL_DT3_214_EEG_Code"
names(vigall_sma)[2:1201] = c(paste0("T",as.character(1:1200)))

# check for duplicates
sum(duplicated(vigall_sma$VIGALL_DT3_214_EEG_Code)) # one duplicate (zero in synthetic dataset)
sum(duplicated(df$SIC)) # zero duplicates

# any duplicates in selection? - Nope.
sum(df$VIGALL_DT3_214_EEG_Code %in% vigall_sma$VIGALL_DT3_214_EEG_Code) # 468 hits
sum(vigall_sma$VIGALL_DT3_214_EEG_Code %in% df$VIGALL_DT3_214_EEG_Code) # 468 hits
vigall_sma$VIGALL_DT3_214_EEG_Code[duplicated(vigall_sma$VIGALL_DT3_214_EEG_Code)] %in% df$VIGALL_DT3_214_EEG_Code # should be FALSE

# merge datasets
merge = left_join(bigv, vigall_sma, by="VIGALL_DT3_214_EEG_Code")

# --------------------
# -- draw boxplots ---
# --------------------

# create function to draw boxplots
makeboxplot = function(df, xvarname, xvarlabel, yvarname, yvarlabel, fillcolors, show.yaxis) {
  
  if (show.yaxis == TRUE) {
    scaleycontinuous = scale_y_continuous(name = yvarlabel)
  } else {
    scaleycontinuous = scale_y_continuous(name = '')
    }

  dfplot = ggplot(bigv, aes_string(x = paste0(xvarname), fill = paste0(xvarname), y = yvarname)) +
    stat_boxplot(geom = "errorbar", width = 0.5, lwd = 0.2) +       
    geom_boxplot(fill = fillcolors, alpha = 1, outlier.shape = NA, lwd = 0.2) +
    geom_point(alpha= 0.15, size = 0.8, shape = 16, position = position_jitterdodge(), show.legend = FALSE) +
    scale_x_discrete(name = xvarlabel) +
    scaleycontinuous +
    theme_bw() +
    theme(plot.margin=margin(5.5,5.5,-1,5.5),
          axis.title = element_text(size = 8),
          axis.title.x = element_text(size = 9, margin = margin(t = 5, r = 0, b = 0, l = 0)),
          axis.title.y = element_text(size=9,margin = margin(t = 0, r = 5, b = 0, l = 0)),
          axis.text.x = element_text(size=8, angle = 0, hjust=0.5, vjust=0.5),
          axis.text.y = element_text(size=8),
          panel.border = element_rect(size = 0.25),
          line = element_line(size=0.25))
}

# draw boxplots for bigv personality traits
set.seed(2962)
fillcolors = c('#1B99C1','#C05351')
N_bp = makeboxplot(merge, 'NEO_N_T_mediansplit', 'Neuroticism', 'VIGALL_DT3_214_V_LogSqR_adj', 'EEG-vigilance (slope index)', fillcolors, TRUE)
E_bp = makeboxplot(merge, 'NEO_E_T_mediansplit', 'Extraversion', 'VIGALL_DT3_214_V_LogSqR_adj', 'EEG-vigilance (slope index)', fillcolors, FALSE)
O_bp = makeboxplot(merge, 'NEO_O_T_mediansplit', 'Openness', 'VIGALL_DT3_214_V_LogSqR_adj', 'EEG-vigilance (slope index)', fillcolors, FALSE)
A_bp = makeboxplot(merge, 'NEO_A_T_mediansplit', 'Agreeableness', 'VIGALL_DT3_214_V_LogSqR_adj', 'EEG-vigilance (slope index)', fillcolors, FALSE)
C_bp = makeboxplot(merge, 'NEO_C_T_mediansplit', 'Conscientiousness', 'VIGALL_DT3_214_V_LogSqR_adj', 'EEG-vigilance (slope index)', fillcolors, FALSE)

# merge into one plot
boxplots = N_bp + E_bp + O_bp + A_bp + C_bp + plot_layout(ncol = 5)
boxplots

# save plot
png(filename = 'code/figures/boxplots.png', width=7.59, height=2.89, units = "in", res = 600)
boxplots
dev.off()

# ----------------------------
# -- make time series plot ---
# ----------------------------

maketsplot = function(df, varname, varlabel, fillcolors) {
  
  # create data frame
  dfplot = data.frame(matrix(nrow = 1200*2, ncol = 6))
  names(dfplot) = c('group', 'time', 'mean', 'se', 'lower', 'upper')
  dfplot$group = factor(c(rep(1,1200), rep(2,1200)), levels = c(1:2), labels = c('low', 'high'))
  dfplot$time = rep((1:1200)/60,2) 
  
  # add group means
  colT1 = which(names(df) %in% 'T1' ); colT1200 = colT1 + 1199
  df = data.frame(df)
  dfplot$mean[1:1200] = as.vector(sapply(df[df[,varname] == 'low', colT1:colT1200], mean))
  dfplot$mean[1201:2400] = as.vector(sapply(df[df[,varname] == 'high', colT1:colT1200], mean))
              
  # add group standard errors
  se = function(x) sd(x)/sqrt(length(x))
  dfplot$se[1:1200] = as.vector(sapply(df[df[,varname] == 'low', colT1:colT1200], se))
  dfplot$se[1201:2400] = as.vector(sapply(df[df[,varname] == 'high', colT1:colT1200], se))
  dfplot$lower = dfplot$mean - dfplot$se
  dfplot$upper = dfplot$mean + dfplot$se

  # draw plot
  ggplot(dfplot, aes(x = time, y = mean, group = group, colour = group, fill = group)) +
    geom_ribbon(aes(x = time, ymin = lower, ymax = upper), color = "NA", alpha=.2) +
    geom_line(size = 0.25) +
    ggtitle(label = varlabel) +
    scale_color_manual(values = fillcolors) +
    scale_fill_manual(values = fillcolors) +
    scale_x_continuous(name = 'Time in resting-state (min)', breaks = seq(0,20,5), labels = seq(0,20,5), expand = c(0, 0)) + # varlabel(i)
    scale_y_continuous(name = 'EEG-vigilance', limits = c(4.2,5.8), breaks = seq(4.2,5.8,0.4)) + # limits = limits[,i],
    expand_limits(x = 0) +
    theme_bw() +
    theme(plot.margin=margin(5.5,5.5,5.5,5.5),
          legend.title = element_blank(),
          legend.text = element_text(size = 7),
          plot.title = element_text(size = 8, hjust = 0.5, face = 'bold'),
          axis.title = element_text(size = 8),
          axis.title.x = element_text(size = 8, margin = margin(t = 5, r = 0, b = 0, l = 0)),
          axis.title.y = element_text(size = 8,margin = margin(t = 0, r = 5, b = 0, l = 0)),
          axis.text.x = element_text(size = 7, angle = 0, hjust = 0.5, vjust = 0.5),
          axis.text.y = element_text(size = 7),
          panel.border = element_rect(size = 0.25),
          line = element_line(size=0.25))
}

# draw time courses for bigv personality traits
N_ts = maketsplot(merge, 'NEO_N_T_mediansplit', 'Neuroticism', c('#1B99C1','#C05351'))
E_ts = maketsplot(merge, 'NEO_E_T_mediansplit', 'Extraversion', c('#1B99C1','#C05351'))
O_ts = maketsplot(merge, 'NEO_O_T_mediansplit', 'Openness', c('#1B99C1','#C05351'))
A_ts = maketsplot(merge, 'NEO_A_T_mediansplit', 'Agreeableness', c('#1B99C1','#C05351'))
C_ts = maketsplot(merge, 'NEO_C_T_mediansplit', 'Conscientiousness', c('#1B99C1','#C05351'))

# merge into one plot
layout = "AAABBBCCC
          DDDEEEF##"
timeseries = N_ts + E_ts + O_ts + A_ts + C_ts + guide_area()
timeseries = timeseries + plot_layout(design = layout, guides = 'collect')
timeseries

# save plot
png(filename = 'code/figures/timeseries.png', width=5.18, height=4.81, units = "in", res = 600)
timeseries
dev.off()

