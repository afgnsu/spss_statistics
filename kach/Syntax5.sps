﻿* Encoding: UTF-8.
GET FILE='p:\BP.sav'.

GRAPH
  /SCATTERPLOT(BIVAR)=obese WITH bp
  /MISSING=LISTWISE.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(obese) TYPE=SCALE
/Y=VAR(bp) TYPE=SCALE
/FITLINE METHOD=REGRESSION LINEAR
LINE=total
/SCATTER COINCIDENT=NONE.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(obese) TYPE=SCALE
/Y=VAR(bp) TYPE=SCALE
/COORDINATE=VERTICAL
/FITLINE METHOD=LLR EPANECHNIKOV BANDWIDTH=CONSTRAINED LINE=total
/YLENGTH=5.2
/X1LENGTH=6.5
/SCATTER COINCIDENT=NONE.

CORRELATIONS
  /VARIABLES=obese bp
  /PRINT=TWOTAIL SIG
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=obese bp
  /PRINT=BOTH TWOTAIL SIG
  /MISSING=PAIRWISE.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(obese) TYPE=SCALE
/Y=VAR(bp) TYPE=SCALE
/COORDINATE=VERTICAL
/FITLINE METHOD=LLR EPANECHNIKOV BANDWIDTH=CONSTRAINED LINE=total
/FITLINE METHOD=REGRESSION LINEAR
/YLENGTH=5.2
/X1LENGTH=6.5
/SCATTER COINCIDENT=NONE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95)
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT bp
  /METHOD=ENTER obese.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT bp
  /METHOD=ENTER obese.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95)
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT bp
  /METHOD=ENTER obese
  /SAVE PRED ZRESID.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(obese) TYPE=SCALE
/Y=VAR(ZRE_1) TYPE=SCALE
/COORDINATE=VERTICAL
/FITLINE METHOD=LLR EPANECHNIKOV BANDWIDTH=CONSTRAINED LINE=total
/YLENGTH=5.2
/X1LENGTH=6.5
/SCATTER COINCIDENT=NONE.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(obese) TYPE=SCALE
/Y=VAR(ZRE_1) TYPE=SCALE
/COORDINATE=VERTICAL
/YLENGTH=5.2
/X1LENGTH=6.5
/SCATTER COINCIDENT=NONE.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(PRE_1) TYPE=SCALE
/Y=VAR(ZRE_1) TYPE=SCALE
/COORDINATE=VERTICAL
/YLENGTH=5.2
/X1LENGTH=6.5
/SCATTER COINCIDENT=NONE.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(PRE_1) TYPE=SCALE
/Y=VAR(ZRE_1) TYPE=SCALE
/LINE   
/COORDINATE=VERTICAL
/FITLINE METHOD=REGRESSION LINEAR
/SCATTER COINCIDENT=NONE.

GRAPH
  /HISTOGRAM(NORMAL)=ZRE_1.

PPLOT
  /VARIABLES=ZRE_1
  /NOLOG
  /NOSTANDARDIZE
  /TYPE=Q-Q
  /FRACTION=BLOM
  /TIES=MEAN
  /DIST=NORMAL.

COMPUTE lpb=LN(bp).
EXECUTE.

EXAMINE VARIABLES=obese BY sexnr
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

GRAPH
  /SCATTERPLOT(BIVAR)=obese WITH bp BY sexnr
  /MISSING=LISTWISE.

IGRAPH
/VIEWNAME='Scatterplot'
/X1=VAR(obese) TYPE=SCALE
/Y=VAR(bp) TYPE=SCALE
/FITLINE METHOD=LLR EPANECHNIKOV BANDWIDTH=CONSTRAINED LINE=total
/YLENGTH=5.2
/X1LENGTH=6.5
/SCATTER COINCIDENT=NONE.




