* Encoding: UTF-8.
DATASET ACTIVATE DataSet2.
COMPUTE BMI=weight/(height/100) ** 2.
EXECUTE.

MEANS TABLES=pemax BY sex
  /CELLS=MEAN COUNT STDDEV MEDIAN MIN MAX.

FREQUENCIES VARIABLES=pemax
  /NTILES=4
  /STATISTICS=MEAN STDDEV MEDIAN
  /ORDER=ANALYSIS.

GET FILE = 'p:\bissau.sav'.
DISPLAY NAMES.

FREQUENCIES VARIABLES=bcg dtp dead
  /ORDER=ANALYSIS.

CROSSTABS
  /TABLES=bcg BY dead
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.


*Set working directory.
cd 'P:\'.
*Open data file.
GET FILE='P:\bissau.sav'.
* Make small data set.
SAVE OUTFILE= 'P:\small.sav'
  /KEEP bcg dtp dead.

GET FILE='P:\bissau.sav'.
SAVE OUTFILE='P:\alsosmall.sav'
  /DROP id agemm sex region ethnic.

GET FILE='P:\bissau.sav'.
SELECT IF (agemm <= 3).
FREQUENCIES VARIABLES=dtp dead.

SORT CASES  BY sex.
SPLIT FILE SEPARATE BY sex.

SPLIT FILE OFF.

GET FILE='P:\pemax.sav'.

SORT CASES  BY sex.
SPLIT FILE SEPARATE BY sex.

FREQUENCIES VARIABLES=pemax
  /FORMAT=NOTABLE
  /NTILES=4
  /STATISTICS=MEDIAN
  /ORDER=ANALYSIS.


GET FILE='P:\bissau.sav'.

FREQUENCIES ethnic region
/FORMAT NOTABLE
/BARCHART.


