---
title: Replication Archive for Decoupling Visualization and Testing When Presenting Confidence Intervals
author: David A. Armstrong II and William Poirier
date: September 28, 2024
---

This is the replication archive for "Decoupling Visualization and Testing When Presenting Confidence Intervals" by Dave Armstrong and William Poirier. 

## Setup

The analysis was done in R v4.4.0 and Stata v.18.  

### R 

The code uses `rstan` to estimate and interact with Bayesian analyses.  Installing `rstan` may require you to have a properly configured C++ toolchain.  You can read more about the requirements of `rstan` and some suggestions for installing and configuring the C++ toolchain for Windows, Mac and Linux [here](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started).  Once you have done this, you can continue with the rest of the installation.  

Only files `code/12_Gill_Retail_Sales_Analysis.R`, `code/13_FigureA7.R` and `code/16_FigureA10.R` deal with Bayesian analyses.  You could install the relevant packages, minus `rstan`, then run all files except those mentioned directly above to generate the Frequentist results.

The replication archive uses `renv` an environment to ensure replicability by keeping track of packages and versions used.  The easiest way to replicate our work is to download the archive in full.  There are two ways to interact with the `renv` package. 

1. Open the .Rproj file in RStudio.  Rstudio should recognize the use of `renv()` and give a message indicating that `renv::status()` will identify gaps in your existing package library.  You can install all the relevant packages with: `renv::restore()`.  This will download the correct versions of the packages into this particular project without changing packages or versions in your global installation of R.  
2. In R, change the working directory to the downloaded archive.  Invoke `renv::restore()`.  You will likely get a message indicating that this is your first time using `renv` and a message about how it works and what changes it makes to the system.  You will be asked to proceed, indicate "y" for Yes.  You will then be asked how you want to proceed, select "Activate the project and use the project library".  This will download the correct versions of the packages into this particular project without changing packages or versions in your global installation of R.   

The `VizTest` package is installed from the author's GitHub page.  The default way GitHub packages are installed by `renv` requires a github personal access token (PAT) that is either set through an environment variable (discouraged) or with the `gitcreds` package.  If you do not wish to proceed that way, let `renv::restore()` finish - it will indicate an error regarding GitHub credentials when it tries to install `VizTest`, but the remainder of the installation should succeed.  After that, you can install the `VizTest` package directly with: 

```
remotes::install_github("davidaarmstrong/VizTest", ref="a717dd2")
```

Using `ref="a717dd2"` will ensure you get the version of the package that was current at the time of acceptance.  For the newest version of the package (which may operate differently depending on development) simply remove the `ref` argument. 

All R packages can be loaded and potential function conflicts resolved with the script `code/00_setup.R`.  The output from `sessionInfo()` is as follows:

```
R version 4.4.0 (2024-04-24)
Platform: aarch64-apple-darwin20
Running under: macOS Sonoma 14.5

Matrix products: default
BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
LAPACK: /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

time zone: America/Toronto
tzcode source: internal

attached base packages:
[1] grid      stats     graphics  grDevices datasets  utils     methods   base     

other attached packages:
 [1] remotes_2.5.0       xtable_1.8-4        BaM_1.0.3           rstan_2.32.6        StanHeaders_2.32.10
 [6] posterior_1.6.0     tidybayes_3.0.7     gridExtra_2.3       ggeffects_1.7.1     multcomp_1.4-26    
[11] TH.data_1.1-2       MASS_7.3-60.2       mvtnorm_1.3-1       effects_4.2-2       carData_3.0-5      
[16] survey_4.4-2        survival_3.6-4      Matrix_1.7-0        rio_1.2.3           VizTest_0.1        
[21] HDInterval_0.2.4    tidyr_1.3.1         dplyr_1.1.4         ggplot2_3.5.1      

loaded via a namespace (and not attached):
 [1] svUnit_1.0.6         tidyselect_1.2.1     loo_2.8.0            R.utils_2.12.3       tensorA_0.36.2.1    
 [6] rpart_4.1.23         lifecycle_1.0.4      magrittr_2.0.3       compiler_4.4.0       rlang_1.1.4         
[11] tools_4.4.0          utf8_1.2.4           pkgbuild_1.4.4       abind_1.4-8          withr_3.0.1         
[16] purrr_1.0.2          R.oo_1.26.0          nnet_7.3-19          stats4_4.4.0         fansi_1.0.6         
[21] jomo_2.7-6           colorspace_2.1-1     mice_3.16.0          inline_0.3.19        iterators_1.0.14    
[26] scales_1.3.0         insight_0.20.4       cli_3.6.3            generics_0.1.3       RcppParallel_5.1.9  
[31] rstudioapi_0.16.0    minqa_1.2.8          DBI_1.2.3            splines_4.4.0        parallel_4.4.0      
[36] matrixStats_1.4.1    mitools_2.4          vctrs_0.6.5          boot_1.3-30          glmnet_4.1-8        
[41] sandwich_3.1-1       arrayhelpers_1.1-0   mitml_0.4-5          ggdist_3.3.2         foreach_1.5.2       
[46] glue_1.7.0           pan_1.9              nloptr_2.1.1         codetools_0.2-20     distributional_0.5.0
[51] shape_1.4.6.1        gtable_0.3.5         QuickJSR_1.3.1       lme4_1.1-35.5        munsell_0.5.1       
[56] tibble_3.2.1         pillar_1.9.0         R6_2.5.1             lattice_0.22-6       R.methodsS3_1.8.2   
[61] backports_1.5.0      broom_1.0.6          renv_1.0.9           Rcpp_1.0.13          coda_0.19-4.1       
[66] nlme_3.1-164         checkmate_2.3.2      zoo_1.8-12           pkgconfig_2.0.3 
```

### Stata

The software demonstration for the package has Stata code in addition to R code for the Frequentist analysis.  We used Stata 18.0 for the computation, though we it relies primarily on Stata and Mata matrix operations, so it will likely work on earlier versions as well.  The code also uses `margins` and `marginsplot` which would require at least version 12.  For Stata you'll need to install the following: 

```
net install viztest, from("https://raw.githubusercontent.com/davidaarmstrong/viztest_stata/main/") 
ssc install matsort
```

Computation time for the 

## Data

The analysis in the article relies on replication archives from three published studies. 

- Gibson, James L. [Forthcoming] "Losing Legitimacy: THe Challenges of the Dobbs Ruling to Conventional Legitimacy Theory". _American Journal of Political Science_. Gibson's replication archive can be found [here](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/AO7IYJ).  In the interest of space, we keep only the unaltered files from the original archive that we need in: `data/raw/gibson_replication`.  With the script file `code/01_process_gibson_data.R`, the original data is filtered and managed to produce `data/analysis/gibson_replication/gibson_dat.rda` for the R portion of the analysis and `data/analysis/gibson_replication/gibson_dat.dta` for the Stata portion of the analysis. 

- Iyengar, Shanto and Sean J. Westwood.  (2015) "Fear and Loathing Across Party Lines: New Evidence on Group Polarization". _American Journal of Political Science_ 59(3): 690--707. Iyengar and Westwood's replication archive can be found [here](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/26662).  In the interest of space, we keep only the unaltered files from the original archive that we need in: `data/raw/iyengar_westwood_replication/`.  With the script file `code/02_process_iyengar_data.R`, we select and recode the relevant variables, filter the data and save as `data/analysis/iyengar_westwood_replication/iw_dat.rda` for the R portion of the analysis and `data/analysis/iyengar_westwood_replication/iw_dat.dta` for the Stata portion of the analysis. 

- Muraoka, Taishi and Guillermo Rosas. (2021) "Does Economic Inequality Drive Voters' Disagreement about Party Placement?". _American Journal of Political Science_ 65(3): 582--597. Muraoka and Rosas' replication archive can be found [here](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/TL0PZD).  In the interest of space, we keep only the unaltered files from the original archive that we need in: `data/raw/muraoka_rosas_replication/`.  With the script `code/03_process_muraoka_data`, we select the relevant variables produce the data and save it in `data/analysis/muraoka_rosas_replication/mr_data.dta`.  One caveat here is that we do not re-estimate the models produced by Muraoka and Rosas.  We simply use the pre-estimated models available in the replication archive.  

## Analysis

The `Master.R` file sources all the individual code files that produce the results.  Running `Master.R` will generate all figures in the `results/` directory.  One thing to note is that in the `Master.R` file there is a call to `system()` which calles `R CMD BATCH` on a file and sends the output to a text file.  Code is commented out right below that line to simply source the file in and the output will print to the console.  The file names produced by the script are all self explanatory. Computation time in R was roughly 1 minute, 20 seconds. 


The `Master.do` file installs the two necessary packages and then runs the Stata code from the software demonstration in Appendix 7.  The computation time in Stata was roughly 5 seconds. 

## File Structure

The file structure is as follows: 

├── Readme.md: This file
├── Master.R: Main R file that calls all individual R files
├── Master.do: Main .do file that calls all individual .do files
├── LICENSE: The license file for the archive - MIT. 
├── code
│   ├── 00_setup.R: Load packages and resolve function conflicts
│   ├── 01_process_gibson_data.R: Process raw Gibson replication data
│   ├── 02_process_iyengar_data.R: Process raw Iyengar and Westwood replication data
│   ├── 03_process_muraoka_data.R: Process raw Muraoka and Rosas replication data
│   ├── 04_Figure1.R: R code to produce Figure 1 in the print article 
│   ├── 05_gibson_text_discussion.R: R code to produce the numbers used in the text
│   ├── 06_Figure2.R: R code to produce Figure 2 in the print article 
│   ├── 07_FigureA1.R: R code to produce Figure 1 in the Online Appendix
│   ├── 08_FigureA2.R: R code to produce Figure 2 in the Online Appendix
│   ├── 09_FigureA3.R: R code to produce Figure 3 in the Online Appendix
│   ├── 10_FigureA4.R: R code to produce Figure 4 in the Online Appendix
│   ├── 11_FigureA5.R: R code to produce Figure 5 in the Online Appendix
│   ├── 12_Gill_Retail_Sales_Analysis.R: Produce Figure 6, Table 1 and Table 2 in Online Appendix
│   ├── 13_FigureA7.R: R code to produce Figure 7 in the Online Appendix
│   ├── 14_FigureA8.R: R code to produce Figure 8 in the Online Appendix
│   ├── 15_FigureA9.R: R code to produce Figure 9 in the Online Appendix
│   ├── 16_FigureA10.R: R code to produce Figure 10 in the Online Appendix
│   ├── 17_FigureA11.do: R code to produce Figure 11 in the Online Appendix
│   └── 18_FigureA12.do: R code to produce Figure 12 in the Online Appendix
├── armstrong_poirier.Rproj: R project file
├── data
│   ├── analysis
│   │   ├── gibson_replication
│   │   │   ├── gibson_dat.dta: Stata dataset for Gibson Replication
│   │   │   └── gibson_dat.rda: R workspace for Gibson Replication 
│   │   ├── iyengar_westwood_replication
│   │   │   ├── iw_dat.dta: Stata dataset for Iyengar and Westwood replication
│   │   │   └── iw_dat.rda: R workspace for Iyengar and Westwood replication
│   │   └── muraoka_rosas_replication
│   │       └── mr_data.rda: R workspace for Muraoka and Rosas replication
│   └── raw
│       ├── gibson_replication: Relevant files unaltered from replication archive 
│       ├── iyengar_westwood_replication: Relevant files unaltered from replication archive
│       └── muraoka_rosas_replication: Relevant files unaltered from replication archive contents
├── renv: Information to install all needed packages. 
├── renv.lock: Versions of used R packages
└── results: Results generated by R and Stata script files - file names self-explanatory
    ├── Figure1.pdf
    ├── Figure2.pdf
    ├── FigureA1.png
    ├── FigureA10.png
    ├── FigureA11.png
    ├── FigureA12.png
    ├── FigureA2.png
    ├── FigureA3.png
    ├── FigureA4.png
    ├── FigureA5.png
    ├── FigureA6.png
    ├── FigureA7.png
    ├── FigureA8.png
    ├── FigureA9.png
    ├── gibson_text_discussion.txt
    ├── TableA1.tex
    └── TableA2.tex

