* Encoding: UTF-8.
GET FILE='P:\bissau.sav'.

* contingency table 
shows that the risk is 
0.043 for vaccinated 
0.041 for unvaccinated
.
CROSSTABS
  /TABLES=dtp BY dead
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ RISK
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.

* odds are 
0.043/(1-0.043) for vaccinated 
0.041/(1-0.041) for unvaccinated
.
CROSSTABS
  /TABLES=ethnic BY dead
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ RISK
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.

* new variable.
RECODE dead (1=1) (2=0) INTO y.
EXECUTE.
* model the risk P(y=1)=P(dead=1).
LOGISTIC REGRESSION VARIABLES y
  /METHOD=ENTER dtp
  /CONTRAST (dtp)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES y
  /METHOD=ENTER agemm
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES y
  /METHOD=ENTER dtp bcg agemm
  /CONTRAST (bcg)=Indicator
  /CONTRAST (dtp)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).
