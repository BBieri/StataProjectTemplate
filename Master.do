* ==============================================================================
* Date: 	<Insert Date>
* Project: 	<Insert Title>
*
* Authors: 
*			- <Insert Authors and Email Adresses>
*			
* Purpose: 	<Insert a Brief Description of the Project>
*
* Datasets used: 
*			- <Insert names of datasets used>
* Output:
*			- <Insert names of datasets, graphs, and tables produced>
* 
* Key Variables:
*			- <Insert list of key variables>
* Sysinfo:
*			- <Add Sysinfo here>
* ==============================================================================

**# Initial Housekeeping =======================================================

// update all // Update Stata if required
clear all
set more off 	// Keeps code from being blocked by more message
cap log close 	// Closing logs that might be open in the current session.

**# Installing Required Packages ===============================================

// List any commands from additional packages or user written functions
// used within this project.

local user_commands ietoolkit iefieldkit
foreach command of local user_commands {
	cap which `command'
    if _rc == 111 {
		ssc install `command'
    }
 }
 
// Loop to update packages to their latest version.
//foreach command of local user_commands {
//	cap which `command'
//    if _rc == 111 {
//		adoupdate `command'
//    }
// }

**# Setting Users and Paths ====================================================

// Set this value to the user currently using this file
global user  "username"

if user == "username" {
    global projectfolder "C:\Users\username\Documents\StataProjectTemplate"
}

 if user == "" {
    global projectfolder ""  	// Enter the file path to the project folder
								// and add ifelse if more than two users.
 }

global data "$projectfolder\Data"
global raw "$data\0_Raw"
global intermediatedata "$data\1_Intermediate"
global outdata "$data\2_Out"
global tempdata "$data\99_Temp"

global dofiles "$projectfolder\Do"
global doimport "$dofiles\0_Import"
global doclean "$dofiles\1_Clean"
global doanalysis "$dofiles\2_Analysis"
global dooutput "$dofiles\3_Output"

global graphs "$projectfolder\Graphs"

global tables "$projectfolder\Tables"

global logs "$projectfolder\Logs"

cd $data // Set current directory to root folder

**#  Running the do files ======================================================

// NB: Run is silent, do echoes in the console

* Global setup of constants (exchange rates, scale conversions, etc.)
// From ietoolkit setup by DIME
do "$dofiles\global_setup.do"

* Import data
do "$doimport\0_import.do"

* Clean data
do "$doclean\0_clean.do"

* Analyze data
do "$doanalysis\0_analysis.do"
