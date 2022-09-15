* ==============================================================================
* Date: 	<Insert Date>
* Project: 	<Insert Title>
* Do-file title: Importing data
*
* Authors: 	- <Insert Authors and Email Adresses>
*
* Purpose: 	Load imported datasets and clean them.
*
* Datasets used: 
*			- <Insert names of datasets used>
* Output: <Insert names of datasets, graphs, and tables produced>
* 
* Key Variables: <Insert list of key variables>
* ==============================================================================

clear all
log close _all

**# Set local data paths and start logging ====
global projectfolder "C:\Users\bjorn\Documents\WB\GitHub\StataProjectTemplate"
global data "$projectfolder\Data"
global raw "$data\0_Raw"
global intermediatedata "$data\1_Intermediate"
global outdata "$data\2_Out"
global tempdata "$data\99_Temp"

global logclean "$projectfolder\Logs\1_Clean\log_clean.log"
log using "$logclean", replace name(DataClean)


**#  Load Datasets =============================================================

use "$intermediatedata\income_democracy_imported.dta"

**#  Clean the data ============================================================

// Here comes the magic!

**#  Save clean data to out folder =============================================
// NB: Use .dta for ease of reimport down the line and use the "_clean"
// suffix to differentiate with raw and imported datasets.

save "$tempdata\income_democracy_out.dta", replace