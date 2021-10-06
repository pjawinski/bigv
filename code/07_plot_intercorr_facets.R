# ===========================================
# == Plot intercorrelations of NEO facets ===
# ===========================================.

# set working directory
setwd('/Users/philippe/desktop/projects/bigv_arousal')

# detach 'other packages' if there are any
if (!is.null(names(sessionInfo()$otherPkgs))) {
  invisible(lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE))
}

# activate R environment
if (exists('.rs.restartR', mode = 'function')) { .rs.restartR() }
source('renv/activate.R')
renv::activate(getwd())
renv::restore(prompt = FALSE)

# attach packages to current R session
library(htmlwidgets)
library(ggplot2)
library(plotly)
library(ppcor)
library(reshape2)
library(scales)
library(pwr)

# load data (synthetic dataset at 'synthetic/01_bigv_arousal_synthetic.txt')
df = read.delim('code/derivatives/01_bigv_arousal.txt', sep = '\t', header = TRUE)

# define vars of interest
varint = as.data.frame(matrix(c(
  'NEO_N1_T', 'Anxiety N1', 'N1',
  'NEO_N2_T', 'Angry Hostility N2', 'N2',
  'NEO_N3_T', 'Depression N3', 'N3',
  'NEO_N4_T', 'Self-Consciousness N4', 'N4',
  'NEO_N5_T', 'Impulsiveness N5', 'N5',
  'NEO_N6_T', 'Vulnerability N6', 'N6',
  'NEO_E1_T', 'Warmth E1', 'E1',
  'NEO_E2_T', 'Gregariousness E2', 'E2',
  'NEO_E3_T', 'Assertiveness E3', 'E3',
  'NEO_E4_T', 'Activity E4', 'E4',
  'NEO_E5_T', 'Excitement-Seeking E5', 'E5',
  'NEO_E6_T', 'Positive Emotions E6', 'E6',
  'NEO_O1_T', 'Fantasy O1', 'O1',
  'NEO_O2_T', 'Aesthetics O2', 'O2',
  'NEO_O3_T', 'Feelings O3', 'O3',
  'NEO_O4_T', 'Actions O4', 'O4',
  'NEO_O5_T', 'Ideas O5', 'O5',
  'NEO_O6_T', 'Values O6', 'O6',
  'NEO_A1_T', 'Trust A1', 'A1',
  'NEO_A2_T', 'Straightforwardness A2', 'A2',
  'NEO_A3_T', 'Altruism A3', 'A3',
  'NEO_A4_T', 'Compliance A4', 'A4',
  'NEO_A5_T', 'Modesty A5', 'A5',
  'NEO_A6_T', 'Tender-Mindedness A6', 'A6',
  'NEO_C1_T', 'Competence C1', 'C1',
  'NEO_C2_T', 'Order C2', 'C2',
  'NEO_C3_T', 'Dutifulness C3', 'C3',
  'NEO_C4_T', 'Achievement Striving C4', 'C4',
  'NEO_C5_T', 'Self-Discipline C5', 'C5',
  'NEO_C6_T', 'Deliberation C6',  'C6'), ncol = 3, byrow = T))
names(varint) = c('varnames', 'varlabels', 'varlabels.y')

# define function for correlation matrix
makecorr = function(df, varnames, varlabels, varlabels.y = NULL, cronbach = NULL, covnames = NULL, type) {
  
  # prepare data.frame
  if (!is.null(covnames)) { covs = df[,covnames] }
  if (is.null(varlabels.y)) { varlabels.y = varlabels }
  df = df[,varnames]
  names(df) = varlabels.y
  
  # create empty data.frames for rho and pval
  df.rho = df.pval = df.n = data.frame(matrix(data = NA, nrow = length(df), ncol = length(df)))
  names(df.rho) = names(df.pval) = names(df.n) = names(df)
  
  # do calculations
  for (i in 1:(length(df)-1)) {
    for (j in (i+1):length(df)) {
      temp.df = df[!is.na(df[,i]) & !is.na(df[,j]),c(i,j)]
      
      if (is.null(covnames)) { 
        temp.corr = cor.test(temp.df[,1], temp.df[,2], method = type)
      } else {
        temp.corr = pcor.test(temp.df[,1], temp.df[,2], covs[!is.na(df[,i]) & !is.na(df[,j]),], method = type)
      }
      
      df.rho[i,j] = df.rho[j,i] = temp.corr$estimate
      df.pval[i,j] = df.pval[j,i] = temp.corr$p.value
      df.n[i,j] = df.n[j,i] = nrow(temp.df)
      
    }
  }
  
  # fill rho diagonal with ones and p diagonal with zeros OR insert cronbach's alpha
  if (!is.null(cronbach)) {  
    for (i in 1:(length(df))) {
      df.rho[i,i] = cronbach$rho[i]
      df.pval[i,i] = cronbach$p[i]
      df.n[i,i] = cronbach$n[i]
    }
  } else {
    df.rho[i,i] = 1
    df.pval[i,i] = 0
    df.n[i,i] = sum(!is.na(df[,i]))
  }
  
  # add row.names
  df.rho$id = df.pval$id = df.n$id = varlabels
  df.rho = df.rho[,c(length(df.rho),1:(length(df.rho)-1))]
  df.pval = df.pval[,c(length(df.pval),1:(length(df.pval)-1))]
  df.n = df.n[,c(length(df.n),1:(length(df.n)-1))]
  
  # format rho matrix for ggplot
  df.m = melt(df.rho, id="id", variable.name="id_y", value.name="rho", na.rm = F)
  df.m$id = as.character(df.m$id)
  df.m$id = factor(df.m$id, levels=unique(df.m$id))
  df.m$rho = df.m$rho_4color = as.numeric(df.m$rho)
  
  # get rho value where p = 0.05
  sign_threshold = pwr.r.test(n = 468, r = NULL, sig.level = 0.05, power = 0.5, alternative = "two.sided")$r
  
  # use rho as fill gradient - do not color if corresponding p value > 0.05
  df.m$pval = as.numeric(reshape2::melt(df.pval, id="id", variable.name="id_y", value.name="pval", na.rm = F)$pval)
  df.m$rho_4color[df.m$pval > 0.05] = NA # nominal significance

  # add variables for ggplotly tooltip
  df.m$x = df.m$id
  df.m$y = df.m$id_y
  df.m$n = as.numeric(reshape2::melt(df.n, id="id", variable.name="id_y", value.name="n", na.rm = F)$n)
  df.m$p = sprintf("%.6f", as.numeric(df.m$pval))
  df.m$p[as.numeric(df.m$pval) < 0.000001] = sprintf("%.2g", as.numeric(df.m$pval[as.numeric(df.m$pval) < 0.000001]))
  df.m$r = sprintf("%.6f", as.numeric(df.m$rho))
  
  # replace cronbach p-value by NA
  df.m$p[as.numeric(df.m$pval) == -1] = rep("-", sum(as.numeric(df.m$pval) == -1))
  
  # draw plots
  for (plottype in c('plotly', 'ggplot')) {
    if (plottype == 'plotly') { nudgex = 0 } else { nudgex = 0.35 }
    
    tempplot = ggplot(df.m, aes(id_y, id, fill=rho_4color, textx = x, texty = y, textn = n, textr = r, textp = p)) + 
      geom_tile() + 
      geom_text(data = df.m, aes(label = sprintf("%0.2f", round(rho, 2))), size=1.8, hjust = 1, nudge_x = nudgex) +
      theme_bw(base_size=10) + 
      theme(legend.position="right",
            panel.grid = element_blank(),
            axis.text.x = element_text(size = 6, angle = 40, hjust = 0),
            axis.text.y = element_text(size = 6),
            panel.border = element_blank(),
            axis.title.x = element_blank(),
            axis.ticks.x = element_blank(),
            axis.title.y = element_blank(),
            axis.ticks.y = element_blank(),   
            plot.margin = unit(c(5, 25, 5, 7), "mm")) +
      scale_x_discrete(position = "top") +
      scale_y_discrete(limits = rev(levels(df.m$id))) +
      #scale_fill_gradientn(colours = c("#9E2013", "white", "#294979"), values = rescale(x = c(-1, 0, 1), to = c(0, 1)),  na.value="white", guide = "colourbar", breaks = c(-1, -0.5, 0, 0.5, 1), limits = c(-1,1)) +
      scale_fill_gradientn(colours = c("#9E2013", "#FFDAD8", "white", "white", "white", "#D1F8FF", "#294979"), values = rescale(x = c(-1, -sign_threshold-1E-6, -sign_threshold, sign_threshold, sign_threshold+1E-6, 1), to = c(0, 1)),  na.value="white", guide = "colourbar", breaks = c(-1, -0.5, 0, 0.5, 1), limits = c(-1,1)) +
      guides(fill = guide_colourbar(title = 'rho', direction = 'vertical', title.position = 'top', title.theme = element_text(size = 7, hjust = 0), label.theme = element_text(size = 6, hjust = 0.5), barwidth = 0.5, barheight = 10, ticks = F, limits = c(-1,1)))
    
    if (plottype == 'plotly') { 
      tempplot = ggplotly(tempplot, tooltip = c("textx", "texty", "textn", "textr", "textp", "textn"), dynamicTicks = FALSE, width = 1100, height = 750)
      tempplot = tempplot %>% config(displayModeBar = F) %>% layout(xaxis=list(side = "top", fixedrange=TRUE)) %>% layout(yaxis=list(fixedrange=TRUE))
      tempplot$x$data[[3]]$marker$colorbar$outlinecolor = "transparent"
    }
    
    assign(paste0('df.', plottype), tempplot)
  }
  
  # return results (rho + pval + n + plot)
  results = list("rho" = df.rho, "pval" = df.pval, "n" = df.n, "ggplot" = df.ggplot, "plotly" = df.plotly)
  results
}

# set internal consistency (see SPSS calculations)
cronbach = data.frame(rho = c(0.803, 0.697, 0.773, 0.668, 0.529, 0.735,
                 0.722, 0.745, 0.826, 0.660, 0.577, 0.796,
                 0.682, 0.756, 0.702, 0.601, 0.740, 0.458,
                 0.682, 0.539, 0.681, 0.548, 0.700, 0.485,
                 0.685, 0.585, 0.614, 0.637, 0.710, 0.681),
                 n = c(467, 468, 466, 468, 467, 466, 
                 467, 468, 467, 468, 468, 468, 
                 467, 468, 467, 467, 468, 468,
                 468, 467, 468, 468, 467, 468, 
                 468, 467, 468, 468, 468, 468),
                 p = rep(-1,30))

# calculate correlations (ignore tie warning)
results = makecorr(df = df, varnames = varint$varnames, varlabels = varint$varlabels, varlabels.y = NULL, cronbach = cronbach, type = 'spearman')

# draw ggplot as png
png(width = 10.25, height = 5.97, units = "in", res = 300, filename = 'code/figures/intercorr_facets.png')
results$ggplot
dev.off()

# draw ggplots as pdf
pdf(width = 10.25, height = 5.97, file = 'code/figures/intercorr_facets.pdf')
results$ggplot
dev.off()

# draw plotly as html
saveWidget(results$plotly, 'code/figures/intercorr_facets.html', selfcontained = TRUE)
system('rm -rf code/figures/intercorr_facets_files')

# -------------------------------------------------------------
# --- Sanity check: Compare R results with MATLAB estimates ---
# -------------------------------------------------------------

# import facet correlation results as derived using MATLAB
intercorr = read.table('code/tables/intercorr_facets.txt', header = T, sep = '\t')

# check if rho and pval estimates are the same (up to 10 digits)
sum(as.vector(round(results$rho[,2:31],10) != round(intercorr[,2:31],10))) == 0 # no deviations
sum(as.vector(round(results$pval[,2:31],10) != round(intercorr[,32:61],10))) == 0 # no deviations
