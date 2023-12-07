* Encoding: UTF-8.
VARIABLE LABELS
GENDER 'Participant Gender'
SMOKE 'Does Participant Smoke Cigarettes?'
EXERCISE 'How Often Does Participant drink alcohol'.

VALUE LABELS
GENDER 0 'Male' 1 'Female'
/SMOKE EXERCISE
1 'Never'
2 'Sometimes'
3 'Daily'.

MISSING VALUES
GENDER SMOKE EXERCISE (999).

GET FILE='p:\small.sav'.

SORT CASES BY id .
CASESTOVARS
  /ID=id
  /GROUPBY=VARIABLE.

GET FILE='p:\wide.sav'.

VARSTOCASES
 /MAKE VO2 FROM VO2.1 VO2.2
 /INDEX  = tid.
LIST id group.

ADD FILES FILE="p:\hosp1.sav" 
/FILE="p:\hosp2.sav".
SAVE OUTFILE="p:\hosp.sav".

GET FILE = "p:\hosp.sav".
SORT CASE BY id.
SAVE OUTFILE = "p:\merge1.sav".

GET FILE = "p:\quest.sav".
SORT CASE BY id.
SAVE OUTFILE = "p:\merge2.sav".

MATCH FILES 
/FILE="p:\merge1.sav"
/FILE="p:\merge2.sav"
/BY id.

SAVE OUTFILE = "p:\data.sav".


