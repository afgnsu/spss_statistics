﻿* Encoding: UTF-8.

* read data set shoose sub set.
GET FILE='P:\juul2.sav'.
SELECT IF age>25.
COMPUTE lsigf1=LN(sigf1).
EXECUTE.

* 
two separate regression lines (one each gender) in color-coded 
scatterplot.
IGRAPH 
/VIEWNAME='Scatterplot' 
/X1=VAR(age) TYPE = SCALE 
/Y=VAR(lsigf1) TYPE = SCALE 
/COLOR = VAR(sexnr) TYPE = CATEGORICAL
/COORDINATE = VERTICAL 
/FITLINE METHOD = REGRESSION LINEAR LINE = MEFFECT SPIKE=OFF 
/CATORDER VAR(sexnr) (ASCENDING VALUES OMITEMPTY) 
/SCATTER COINCIDENT = NONE.
EXECUTE.


* 
test if interaction is significant
create interaction term and run a regression 
.
COMPUTE interagsjon = sexnr*age.
EXECUTE.

REGRESSION
/STATISTICS COEFF ANOVA CI    
/CRITERIA=PIN(.05) POUT(.10) 
/NOORIGIN
/DEPENDENT lsigf1
/METHOD=ENTER sexnr age
/METHOD=ENTER interagsjon.

* fit model with interaction.
UNIANOVA lsigf1 BY sexnr WITH age
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER
  /PLOT=RESIDUALS
  /CRITERIA=ALPHA(.05)
  /DESIGN=sexnr age*sexnr age.

* fit model with interaction - change order in 'DESIGN'.
UNIANOVA lsigf1 BY sexnr WITH age
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER
  /PLOT=RESIDUALS
  /CRITERIA=ALPHA(.05)
  /DESIGN=sexnr age age*sexnr.

UNIANOVA lsigf1 BY sexnr WITH age
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER
  /PLOT=RESIDUALS
  /CRITERIA=ALPHA(.05)
  /DESIGN=sexnr age.





GET FILE='P:\framingham.sav'.
COMPUTE logSBP=LN(SBP).
EXECUTE.

* separate regression lines.
IGRAPH 
/VIEWNAME='Scatterplot' 
/X1=VAR(chol) TYPE = SCALE 
/Y=VAR(logSBP) TYPE = SCALE 
/COLOR = VAR(sex) TYPE = CATEGORICAL
/COORDINATE = VERTICAL 
/FITLINE METHOD = REGRESSION LINEAR LINE = MEFFECT SPIKE=OFF 
/CATORDER VAR(sex) (ASCENDING VALUES OMITEMPTY) 
/SCATTER COINCIDENT = NONE.
EXECUTE.

* interaction ? .
UNIANOVA logSBP BY SEX WITH CHOL
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER
  /SAVE=PRED RESID
  /CRITERIA=ALPHA(.05)
  /DESIGN=CHOL SEX CHOL*SEX.

* model  without interaction.
UNIANOVA logSBP BY SEX WITH CHOL
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER
  /SAVE=PRED RESID
  /CRITERIA=ALPHA(.05)
  /DESIGN=CHOL SEX.

GRAPH
  /SCATTERPLOT(BIVAR)=chol WITH RES_2
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=PRE_2 WITH RES_2
  /MISSING=LISTWISE.

GRAPH
  /HISTOGRAM(NORMAL)=RES_2
  /PANEL ROWVAR=sex ROWOP=CROSS.

EXAMINE VARIABLES=RES_2 BY sex
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /PANEL ROWVAR=sex ROWOP=CROSS.





