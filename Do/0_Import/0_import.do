* ==============================================================================
* Date: 	<Insert Date>
* Project: 	<Insert Title>
* Do-file title: Importing data
*
* Authors: 	- <Insert Authors and Email Adresses>
*
* Purpose: 	Collect and import datasets from different files, APIs, etc.
*
* Datasets used: 
*			- <Insert names of datasets used>
* Output: <Insert names of datasets, graphs, and tables produced>
* 
* Key Variables: <Insert list of key variables>
* ==============================================================================

clear all
log close _all

**# Set local data paths and start log ====
global projectfolder "C:\Users\bjorn\Documents\WB\GitHub\StataProjectTemplate"
global data "$projectfolder\Data"
global raw "$data\0_Raw"
global intermediatedata "$data\1_Intermediate"
global outdata "$data\2_Out"
global tempdata "$data\99_Temp"

global logclean "$projectfolder\Logs\0_Import\log_import.log"
log using "$logclean", replace name(DataImport)

**#  Start import ==============================================================

// NB: These are example datasets from S-W Econometrics book.
import excel "$raw\income_democracy.xlsx", first
// use "$raw\income_democracy.dta" // Same file

**#  Save to intermediate folder ===============================================
// NB: Use .dta for ease of reimport down the line and use the "_imported"
// suffix to differentiate with raw data.

save "$intermediatedata\income_democracy_imported.dta", replace