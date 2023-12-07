* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=agemm
  /ORDER=ANALYSIS.

DATASET ACTIVATE DataSet1.
RECODE agemm (0 thru 1=1) (2 thru 4=2) (5 thru 6=3) INTO newage.
VARIABLE LABELS  newage 'recoded'.
EXECUTE.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=newage
  /ORDER=ANALYSIS.

* This is a comment and will continue to be a comment until the terminating period.
/* This is a comment and will continue to be a comment until the terminating asterisk-slash */

/* recode the age variable */
DATASET ACTIVATE DataSet1.
RECODE agemm (0 thru 1=1) (2 thru 4=2) (5 thru 6=3) INTO newage.
VARIABLE LABELS  newage 'recoded'.
EXECUTE.
/* tabulate transformed variable */
DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=newage
  /ORDER=ANALYSIS.



* DataSet2 is the juul data set.

DATASET ACTIVATE DataSet2.
COMPUTE BMI=weight/(height/100) ** 2.
EXECUTE.

GRAPH
  /HISTOGRAM(NORMAL)=sigf1
  /PANEL COLVAR=tanner COLOP=CROSS ROWVAR=sexnr ROWOP=CROSS.


EXAMINE VARIABLES=sigf1 BY tanner
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /PANEL ROWVAR=sexnr ROWOP=CROSS.


MEANS TABLES=sigf1 BY tanner
  /CELLS=MEAN COUNT STDDEV MEDIAN MIN MAX.

FREQUENCIES VARIABLES=sigf1
  /NTILES=4
  /STATISTICS=STDDEV MEAN MEDIAN
  /ORDER=ANALYSIS.

