# The Big Five personality traits and brain arousal in the resting state            
[This GitHub repository](https://github.com/pjawinski/bigv) contains the analysis scripts referring to our publication entitled 'The Big Five personality traits and brain arousal in the resting state' ([https://doi.org/10.3390/brainsci11101272](https://doi.org/10.3390/brainsci11101272)). We provide a reproducible and portable R environment, all statistical analysis scripts, and a synthetic dataset to re-run our code.

## Abstract
Based on Eysenck’s biopsychological trait theory, brain arousal has long been considered to explain individual differences in human personality. Yet, results from empirical studies remained inconclusive. However, most published results have been derived from small samples and, despite of inherent limitations, EEG alpha power has usually served as exclusive indicator for brain arousal. To overcome these problems, we here selected N = 468 individuals of the LIFE-Adult cohort and investigated the associations between the Big Five personality traits and brain arousal by using the validated EEG- and EOG-based analysis tool VIGALL. Our analyses revealed that participants who reported higher levels of extraversion and openness to experience, respectively, exhibited lower levels of brain arousal in the resting state. Bayesian and frequentist analysis results were especially convincing for openness to experience. Among the lower-order personality traits, we obtained strongest evidence for neuroticism facet ‘impulsivity’ and reduced brain arousal. In line with this, both impulsivity and openness have previously been conceptualized as aspects of extraversion. We regard our findings as well in line with the postulations of Eysenck and consistent with the recently proposed ‘arousal regulation model’. Our results also agree with meta-analytically derived effect sizes in the field of individual differences research, highlighting the need for large (collaborative) studies.<br>

Keywords: Arousal, Big Five, EEG, Resting State, VIGALL, Extraversion, Neuroticism, Impulsivity<br>

## Folder structure
[code/](code/) - contains all analysis scripts as well as the extracted [tables](code/tables), [figures](code/figures) and required Matlab [functions](code/functions)<br>
[synthetic/](synthetic/) - contains a synthetic dataset that mimics the original observed data<br>
[renv/](renv/) - contains a single file to initiate the R environment (the scripts located in [code/](code/) refer to this file)<br>
[renv.lock](renv.lock) - a list of R packages automatically downloaded and attached to the R environment of this project<br>
[setwd.sh](setwd.sh) - a script to automatically set the working directory in all analysis scripts<br>

## How to use this repository
In order to reproduce our statistical analyses, you should first clone this repository via the the following commands:
```
git clone https://github.com/pjawinski/bigv.git
cd bigv
```
You may then update the specified working directory in each analysis script via the following command:
```
./setwd.sh
```
You are now ready to run all scripts located in [code/](code/) according to their numbering one after another (starting from '02_bayesian_analyses.R'). R scripts can be run from command line or from within RStudio. The R environment is activated by the scripts and required packages are downloaded automatically. Please note that you need to change the relative path of the original dataset (not publicly available) to the synthetic dataset at respective lines.

## Figures
![alt text](https://pjawinski.github.io/bigv/code/figures/timeseries.png "Figure 1")
[Fig. 1](https://pjawinski.github.io/bigv/code/figures/timeseries.png) - Time-courses of EEG-vigilance during the 20-minute eyes-closed resting-state condition stratified by groups scoring low vs. high on the respective Big Five scale (median-split, i.e., participants with scores in the lower vs. upper half of the ascending distribution are compared). Time-courses reflect simple moving averages (± standard error), i.e., every data point represents an averaged 61-second interval of EEG-vigilance (data point in time ± 30 seconds). Statistical analyses revealed significant associations between EEG-vigilance and both extraversion and openness to experience.<br><br><br>

![alt text](https://pjawinski.github.io/bigv/code/figures/boxplots.png "Figure 2")
[Fig. 2](https://pjawinski.github.io/bigv/code/figures/boxplots.png) - Boxplots showing the differences in EEG-vigilance (as indicated by variable ‘slope index’) as a function of Big Five personality trait. Boxplots are stratified by groups scoring low vs. high on the respective Big Five scale (i.e., participants with scores in the lower vs. upper half of the ascending distribution are compared). Boxes represent the interquartile range (data between the lower and upper quartile), with the horizontal line corresponding to the median. Whiskers extend to the fur-thest observation within 1.5 times the interquartile range from the lower and upper quartile. Dots represent single observations, jittered horizontally to avoid overplotting. Statistical analyses revealed significant associations between EEG-vigilance variable ‘slope index’ and both extraversion and openness to experience.<br><br><br>

![alt text](https://pjawinski.github.io/bigv/code/figures/qqplot_full.png "Figure 3")<br><br>
[Fig. 3](https://pjawinski.github.io/bigv/code/figures/qqplot_full.png) - Permutation-based qq-plot showing the observed p-values from the association analyses (blue circles) sorted from largest to smallest and plotted against the expected p-values under the null hypothesis. The solid diagonal line represents the mean expected p-values. The lower and upper bound of the grey area represent the 5th and 95th percentile (-log10 scale) of the expected p-values. Quantile-quantile plots show an excess of low p-values, suggesting that association analyses revealed overall stronger evidence than expected under the null hypothesis of no effect. (a) NEO personality traits (sex and age-normalized T-scores) (b) NEO personality facets (sex and age-normalized T-scores).<br>

![alt text](https://pjawinski.github.io/bigv/code/figures/power.png "Figure S1")
[Fig. S1](https://pjawinski.github.io/bigv/code/figures/power.png) - Power analysis results showing the probability (1-β) of associations to surpass the threshold of significance given true effect sizes ranging between ρ = 0.0 and ρ = 0.4 (with N = 468). The dotted curve shows the probability to reach nominal significance (α = 0.05, two-tailed). The solid curve shows the probability to reach the Bonferroni-corrected level of significance (α = 0.05/15, two-tailed). Power analysis was conducted using R package pwr v1.3-0 (Champely, 2020).<br><br><br>

![alt text](https://pjawinski.github.io/bigv/code/figures/intercorr_facets.png "Figure S2")
[Fig. S2](https://pjawinski.github.io/bigv/code/figures/intercorr_facets.html) - NEO personality facets - Cronbach’s α and intercorrelations. Only cells containing correlations with nominal significance (p < 0.05) have been assigned with colors of the blue and red color palette. Values of the main diagonal reflect the internal consistency as estimated using Cronbach’s α.<br><br><br>

![alt text](https://pjawinski.github.io/bigv/code/figures/qqplot_partial.png "Figure S3")<br><br>
[Fig. S3](https://pjawinski.github.io/bigv/code/figures/qqplot_partial.png) - Permutation-based qq-plot showing the observed p-values from the association analyses (blue circles) sorted from largest to smallest and plotted against the expected p-values under the null hypothesis. The solid diagonal line represents the mean expected p-values. The lower and upper bound of the grey area represent the 5th and 95th percentile (-log10 scale) of the expected p-values. (a) NEO personality traits (sex and age-normalized T-scores) adjusted by sex, age, and time of EEG assessment. (b) NEO personality facets (sex and age-normalized T-scores) adjusted by sex, age, and time of EEG assessment.<br>
