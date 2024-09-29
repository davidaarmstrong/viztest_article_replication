********************************************************************************
 *----------------------------------------------------------------------------*
 *                  Master Stata replication file for                         *
 *  Decoupling Visualization and Testing when Presenting Confidence Intervals *
 *                                     by                                     *
 *                  David A. Armstrong II and William Poirier                 *
 *----------------------------------------------------------------------------* 
********************************************************************************

* 0. Install packages - uncomment two lines below to install packages.  
* net install viztest, from("https://raw.githubusercontent.com/davidaarmstrong/viztest_stata/main/") 
* ssc install matsort

* 1. Make Figure A11
do "code/17_FigureA11.do"

* 2. Make Figure A11
do "code/18_FigureA12.do"

