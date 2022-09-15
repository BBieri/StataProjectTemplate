* ==============================================================================
* Date: 	<Insert Date>
* Project: 	<Insert Title>
* Do-file title: Importing data
*
* Authors: 	- <Insert Authors and Email Adresses>
*
* Purpose: 	Run and estimate models. Produce tables and graphs.
*
* Datasets used: 
*			- <Insert names of datasets used>
* Output: <Insert names of datasets, graphs, and tables produced>
* 
* Key Variables: <Insert list of key variables>
* ==============================================================================

clear all
log close _all

**# Set local data paths which need to be commented out in post-production. ====
global projectfolder "C:\Users\bjorn\Documents\WB\GitHub\StataProjectTemplate"
global data "$projectfolder\Data"
global raw "$data\0_Raw"
global intermediatedata "$data\1_Intermediate"
global outdata "$data\2_Out"
global tempdata "$data\99_Temp"

global graphs "$projectfolder\Graphs"
global tables "$projectfolder\Tables"

global loganalysis"$projectfolder\Logs\2_Analysis\log_analyze.log"
log using "$loganalysis", replace name(DataAnalyze)

**#  Load Datasets =============================================================

use "$outdata\income_democracy_clean.dta"

**#  Run the models ============================================================

egen country_id = group(country), label lname(country)
xtset country_id year

xtreg log_gdppc log_pop age_1 educ, vce(robust)

**# Generate Tables ============================================================

// Estout Documentation: http://repec.sowi.unibe.ch/stata/estout/

eststo panelestexample1: quietly xtreg log_gdppc log_pop age_1 educ, vce(robust)
eststo panelestexample2: quietly xtreg log_gdppc log_pop age_1 age_2 educ, vce(robust)
esttab, compress

esttab using "$tables\example.tex", label nostar ///
   title(Regression table\label{tab1}) ///
   replace

eststo clear

**# Generate Graphs ============================================================
	
* Create graph
preserve
drop if country_id > 100
drop if country_id < 81
xtline log_gdppc, ytitle(Log GDP per capita (USD))
graph export "$graphs\examplegraph.png", replace
restore

