* Encoding: UTF-8.
*Set working directory.
cd 'P:\'.
*Open data file.
GET FILE='P:\RCT.sav'.
* Make small data set.
SAVE OUTFILE='P:\small.sav'
  /DROP v1 TO v14.

GET FILE='P:\small.sav'.
SELECT IF (time=3).
EXECUTE.
T-TEST GROUPS=group('A' 'B')
  /MISSING=ANALYSIS
  /VARIABLES=VO2
  /CRITERIA=CI(.95).

GET FILE='P:\juul2.sav'.

ONEWAY sigf1 BY tanner
  /PLOT MEANS
  /MISSING ANALYSIS.


UNIANOVA sigf1 BY tanner
  /CONTRAST(tanner)=Simple
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /CRITERIA=ALPHA(0.05)
  /DESIGN=tanner.


NPAR TESTS
  /K-W=sigf1 BY tanner(1 5)
  /STATISTICS QUARTILES
  /MISSING ANALYSIS.


NPAR TESTS
  /K-W=sigf1 BY sexnr(1 2)
  /STATISTICS QUARTILES
  /MISSING ANALYSIS.


