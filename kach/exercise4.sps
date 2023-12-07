* Encoding: UTF-8.

GET FILE='C:\Users\pzs913\Documents\RCT.sav'.
SELECT IF (time=1).
COMPUTE baseline=vo2.
SORT CASES by id.
SAVE OUTFILE='C:\Users\pzs913\Documents\RCT1.sav'
/KEEP id group baseline.
EXECUTE.

GET FILE='C:\Users\pzs913\Documents\RCT.sav'.
SELECT IF (time=3).
COMPUTE followup=vo2.
SORT CASES by id.
SAVE OUTFILE='C:\Users\pzs913\Documents\RCT3.sav'
/KEEP id group followup.
EXECUTE.

MATCH FILES
/FILE='C:\Users\pzs913\Documents\RCT1.sav'
/FILE='C:\Users\pzs913\Documents\RCT3.sav'
/BY id.

COMPUTE delta=followup-baseline.

SAVE OUTFILE='C:\Users\pzs913\Documents\wide.sav'.

GET FILE='C:\Users\pzs913\Documents\RCT.sav'.
SORT CASES BY id.
CASESTOVARS
  /ID=id
  /GROUPBY=VARIABLE.




