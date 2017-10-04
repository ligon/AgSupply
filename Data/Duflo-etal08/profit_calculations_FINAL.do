/*
Do file to generate profitability calculations for 
1. Duflo et al. (2009). "How High are Rates of Return to Fertilizer? Evidence from Field Experiments in Kenya." American Economi Review P&P.
2. Duflo et al. (2010). "Nudging Farmers to use Fertilizer: Theory and Experimental Evidence from Kenya." American Economic Review.

generated June 2011;
*/

#delimit;
set more off;
clear;

****************************;
*replicate papers & proceedings;
****************************;
use profit_data_FINAL, replace;

*************;
*generate rates of return over season;
*for Papers & Proceedings, we value maize at 40 Ksh per goro-goro after the short rains season and 25 Ksh per goro-goro after the long rains season;
*************;
for any t14 t12 t1 ft:
 gen rr_season_X=40*(dryweight_X_m2-dryweight_c_m2)/inputcost_X_m2-1 if long_rains==0 \
 replace rr_season_X=25*(dryweight_X_m2-dryweight_c_m2)/inputcost_X_m2-1 if long_rains==1;


*************;
*generate percentage increase in yield;
*************;
for any t14 t12 t1 ft:
 gen per_increase_X=dryweight_X_m2/dryweight_c_m2-1 \
 replace per_increase_X=0 if dryweight_X_m2==0 & dryweight_c_m2==0;

************;
*note that for annualized rates of return, it is about 7 months from top dressing and 9 months from planting (i.e. for full treatment) to peak price;
************;

******;
*1/4 teaspoon;
******;
sum per_increase_t14, detail;
ci per_increase_t14;
sum rr_season_t14, detail;
ci rr_season_t14;

*annualized return - median;
di (1+-.276558)^(12/7)-1;
*annualized return - mean;
di (1+.0481857)^(12/7)-1; 

******;
*1/2 teaspoon;
******;
sum per_increase_t12, detail;
ci per_increase_t12;
sum rr_season_t12, detail;
ci rr_season_t12;

*annualized return - median;
di (1+.238814)^(12/7)-1;
*annualized return - mean;
di (1+.3603902)^(12/7)-1; 

******;
*1 teaspoon;
******;
sum per_increase_t1, detail;
ci per_increase_t1;
sum rr_season_t1, detail;
ci rr_season_t1;

*annualized return - median;
di (1+-.1694034)^(12/7)-1;
*annualized return - mean;
di (1+-.1077717)^(12/7)-1; 

******;
*Full treatment;
******;
sum per_increase_ft, detail;
ci per_increase_ft;
sum rr_season_ft, detail;
ci rr_season_ft;

*annualized return - median;
di (1+-.4943912)^(12/9)-1;
*annualized return - mean;
di (1+-.3892903)^(12/9)-1; 

****************************;
*calculate statistics for "Nudging Farmers to Use Fertilizer";
*Replicate Appendix Table 2;
*(note that there are 4047 meters-squared in 1 acre;
****************************;

******;
*1/2 teaspoon plot (all farmers);
******;
*Estimated yield on control plot for those using 1/2 teaspoon;
sum dryweight_c_m2 if dryweight_t12_m2!=.;
di r(mean)*4047;

*Estimated yield on 1/2 teaspoon plot;
sum dryweight_t12_m2 if dryweight_t12_m2!=.;
di r(mean)*4047;

*Estimated input cost on 1/2 teaspoon plot (exchange rate = 70 Ksh / USD);
sum inputcost_t12_m2 if dryweight_t12_m2!=.;
di r(mean)*4047/70;

******;
*1 teaspoon plot (all farmers);
******;
*Estimated yield on control plot for those using 1 teaspoon;
sum dryweight_c_m2 if dryweight_t1_m2!=.;
di r(mean)*4047;

*Estimated yield on 1 teaspoon plot;
sum dryweight_t1_m2 if dryweight_t1_m2!=.;
di r(mean)*4047;

*Estimated input cost on 1 teaspoon plot (exchange rate = 70 Ksh / USD);
sum inputcost_t1_m2 if dryweight_t1_m2!=.;
di r(mean)*4047/70;

******;
*1/2 and 1 teaspoon for only those who used both simultaneously;
******;
*Estimated yield on control plot for those using both 1 tsp and 1/2 tsp;
sum dryweight_c_m2 if dryweight_t12_m2!=. & dryweight_t1_m2!=.;
di r(mean)*4047;

*Estimated yield on 1/2 tsp plot for those using both 1 tsp and 1/2 tsp;
sum dryweight_t12_m2 if dryweight_t12_m2!=. & dryweight_t1_m2!=.;
di r(mean)*4047;

*Estimated yield on 1 tesp plot for those using both 1 tsp and 1/2 tsp;
sum dryweight_t1_m2 if dryweight_t12_m2!=. & dryweight_t1_m2!=.;
di r(mean)*4047;

*Estimated input cost on 1/2 teaspoon plot (exchange rate = 70 Ksh / USD);
sum inputcost_t12_m2 if dryweight_t12_m2!=. & dryweight_t1_m2!=.;
di r(mean)*4047/70;

*Estimated input cost on 1 teaspoon plot (exchange rate = 70 Ksh / USD);
sum inputcost_t1_m2 if dryweight_t12_m2!=. & dryweight_t1_m2!=.;
di r(mean)*4047/70;

