﻿* Encoding: UTF-8.
GET FILE='P:\framingham.sav'.
GRAPH
  /HISTOGRAM(NORMAL)=sbp 
  /PANEL ROWVAR=sex ROWOP=CROSS.
GRAPH
  /HISTOGRAM(NORMAL)=chol 
  /PANEL ROWVAR=sex ROWOP=CROSS.

GET FILE='P:\framingham.sav'.
EXAMINE VARIABLES=sbp chol BY sex
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /PANEL ROWVAR=sexnr ROWOP=CROSS.

GET FILE='P:\framingham.sav'.
EXAMINE VARIABLES=sbp chol BY sex
  /PLOT=HISTOGRAM
  /STATISTICS=NONE
  /NOTOTAL
  /PANEL ROWVAR=sexnr ROWOP=CROSS.

GET FILE='P:\framingham.sav'.
T-TEST GROUPS=sex(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=sbp chol
  /CRITERIA=CI(.95).

* This code plots two separate regression lines (one each gender) in a color-coded scatterplot. 
GET FILE='P:\framingham.sav'.
IGRAPH 
/VIEWNAME='Scatterplot' 
/X1=VAR(chol) TYPE = SCALE 
/Y=VAR(sbp) TYPE = SCALE 
/COLOR = VAR(sex) TYPE = CATEGORICAL
/COORDINATE = VERTICAL 
/FITLINE METHOD = REGRESSION LINEAR LINE = MEFFECT SPIKE=OFF 
/CATORDER VAR(sex) (ASCENDING VALUES OMITEMPTY) /SCATTER COINCIDENT = NONE.
EXECUTE.

* Create interaction term and run a regression to see if interaction is significant.
COMPUTE interact = sex*chol.
EXECUTE.
REGRESSION
/STATISTICS COEFF ANOVA 
/CRITERIA=PIN(.05) POUT(.10)
/NOORIGIN
/DEPENDENT sbp
/METHOD=ENTER sex chol
/METHOD=ENTER interact.

UNIANOVA SBP BY SEX WITH CHOL
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER
  /PLOT=RESIDUALS
  /CRITERIA=ALPHA(.05)
  /DESIGN=CHOL SEX.


UNIANOVA SBP BY SEX WITH CHOL
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /SAVE=PRED RESID
  /PRINT=PARAMETER
  /PLOT=RESIDUALS
  /CRITERIA=ALPHA(.05)
  /DESIGN=SEX CHOL*SEX CHOL.

GRAPH
  /SCATTERPLOT(BIVAR)=chol WITH RES_1
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=PRE_1 WITH RES_1
  /MISSING=LISTWISE.

GRAPH
  /HISTOGRAM(NORMAL)=RES_1
  /PANEL ROWVAR=sex ROWOP=CROSS.

EXAMINE VARIABLES=RES_1 BY sex
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /PANEL ROWVAR=sexnr ROWOP=CROSS.



