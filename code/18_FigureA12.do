use "data/analysis/iyengar_westwood_replication/iw_dat.dta", clear

* keep required obs
keep if scholarship == "partisan"

* estimate logit with interaction
quietly logit partisanSelection i.participantPID2##i.mostQualifiedPerson


* equally qualified
* calculate margins for party id
quietly margins participantPID2, at(mostQualifiedPerson = 1)

* find inferential confidence level
viztest, a(.025) lev1(.5) lev2(.95) incr(.001) usemargins

* republican more qualified
* calculate margins for party id
quietly margins participantPID2, at(mostQualifiedPerson = 2)

* find inferential confidence levels
viztest, a(.025) lev1(.5) lev2(.95) incr(.001) usemargins

* democrat more qualified
* calculate margins for party id
quietly margins participantPID2, at(mostQualifiedPerson = 3)

* find inferential confidence level
viztest, a(.025) lev1(.5) lev2(.95) incr(.001) usemargins

* calculate margins for plotting
quietly margins participantPID2, at(mostQualifiedPerson = (1 2 3))

* save results in tabo and keep only estimate
* and lower/upper confidence bounds
mat tabo = r(table)'
mat tabo = tabo[....,1], tabo[....,5], tabo[....,6]

* calculate margins with inferential confidence interval
quietly margins participantPID2, at(mostQualifiedPerson = (1 2 3)) level(84)

* save results in tabo and keep only lower/upper confidence bounds
mat tabi = r(table)'
mat tabi = tabi[....,5], tabi[....,6]

* put results together
mat out = tabo, tabi

* create a new frame and change to the frame
frame create res
frame change res

* place matrix results in the new frame
svmat out, names(out)

* rename all variables
rename out1 estimate
rename out2 lwr95
rename out3 upr95
rename out4 lwr84
rename out5 upr84

* generate most qualified person variable
gen mqp = . 

* replace values to correspond with output from margins
replace mqp = 1 in 1/5
replace mqp = 2 in 6/10
replace mqp = 3 in 11/15

* define an apply levels for mqp
label def mqp 1 "Equally Qualified" 2 "R More Qualified" 3 "D More Qualified"
label val mqp mqp

* generate party id variable
gen pid = .

* repalce values to correspond with output from margins
* democrats
foreach i of num 2 7 12 {
	replace pid = 1 in `i'
}
* lean democrat
foreach i of num 3 8 13 {
	replace pid = 2 in `i'
}

* independent
foreach i of num 1 6 11 {
	replace pid = 3 in `i'
}
* lean republican
foreach i of num 4 9 14 {
	replace pid = 4 in `i'
}
* republican
foreach i of num 5 10 15 {
	replace pid = 5 in `i'
}

* define and apply labels
label def pid 1 "D" 2 "LD" 3 "I" 4 "LR" 5 "R"
label val pid pid

* Make the graph
twoway (pcspike pid lwr95 pid upr95, lwidth(medium) lcolor(gs8)) || ///
  (pcspike pid lwr84 pid upr84, lwidth(vthick) lcolor(black)) || ///
  (scatter pid estimate, mcolor(white) mfcolor(white) msymbol(circle)), ///
  by(mqp, cols(3) compact note("")) ///
  legend(order(2 "Inferential (84%)" 1 "Original (95%)") position(12) cols(2)) ///
  xtitle("Predict Pr(Choose Republican)") ytitle("") ylabel(1 "D" 2 "LD" 3 "I" 4 "LR" 5 "R")

graph export results/FigureA12.png, replace

frame change default
frame drop res
