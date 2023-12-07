* Encoding: UTF-8.
* Set working directory.
cd 'P:\'.
*Open data file.
GET FILE='P:\RCT.sav'.
* Make small data set.

SELECT IF (time=1).
EXECUTE.

T-TEST GROUPS=group('A' 'B')
  /MISSING=ANALYSIS
  /VARIABLES=VO2
  /CRITERIA=CI(.95).

RECODE group ('A'=1) ('B'=2) INTO gr.
VARIABLE LABELS  gr 'group coded by numbers (A=1)'.
EXECUTE.

NPAR TESTS
  /K-W=VO2 BY gr(1 2)
  /STATISTICS QUARTILES
  /MISSING ANALYSIS.

SORT CASES    BY gr.
SPLIT FILE    BY gr.

FREQUENCIES    VARIABLES=VO2
/FORMAT    =NOTABLE    
/NTILES    =4   
/ORDER    =ANALYSIS.

SPLIT FILE    OFF.
GRAPH
  /HISTOGRAM(NORMAL)=VO2
  /PANEL ROWVAR=group ROWOP=CROSS.







