use "data/analysis/gibson_replication/gibson_dat.dta", clear

* run regression
quietly reg agree1 i.WAVE [pw=WEIGHT]

* create effects of categorical variable
margins WAVE
* find inferential confidence levels
viztest, a(.025) usemargins incr(.001)
* calculate margins for plotting
quietly margins WAVE

* save results in tabo and keep only estimate
* and lower/upper confidence bounds
mat tabo = r(table)'
mat tabo = tabo[....,1], tabo[....,5], tabo[....,6]

* calculate margins for inferential confidence level
quietly margins WAVE, level(84)

* save results in tabo and keep only estimate
* and lower/upper confidence bounds
mat tabi = r(table)'
mat tabi = tabi[....,5], tabi[....,6]

* put two results together 
mat out = tabo, tabi


* create a new frame and change to the frame
frame create res
frame change res

* place matrix results in the new frame
svmat out, names(out)

* rename all the variables
rename out1 estimate
rename out2 lwr95
rename out3 upr95
rename out4 lwr84
rename out5 upr84

* generate a variable for the x-axis
gen obs = _n

* make the graph
twoway  (rcapsym lwr95 upr95 obs, lwidth(medium) msymbol(none) lcolor(gs8)) || ///
  (rcapsym lwr84 upr84 obs, lwidth(vthick) msymbol(none) lcolor(black)) || ///
  (scatter estimate obs, mcolor(white) mfcolor(white) msymbol(circle)), ///
  xlabel(1 "July 2020" 2 "December 2020" 3 "March 2021" 4 "July 2022") ///
  legend(order(2 "Inferential (84%)" 1 "Original (95%)") position(12) cols(2)) ///
  xtitle("Wave") ytitle("Proportion Agreeing")

graph export results/FigureA11.png, replace 

frame change default
frame drop res  
