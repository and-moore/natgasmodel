$onText
This model is intended to represent the US natural gas industry
through regional production and consumption, including pipeline
imports from Mexico and Canada and exports via pipeline to
Canada and Mexico as well as via LNG to non-adjacent countries.


Prepared by Andrew Moore for the Fall 2019 semester of EBGN 632
- Primary Fuels, taught by Ian Lange and Maxwell Brown at the
Colorado School of Mines.

All data are as of December 2017, which is the most recent date
for which state-level data is available for all states.
$offText


set

i "producing regions"       /Canada, GOM, Mexico, Midwest, Mountain,
                            Northeast, Pacific, South_Central, Southeast/,
j "consuming regions"       /Canada, LNG_Export, Mexico, Midwest, Mountain,
                            Northeast, Pacific, South_Central, Southeast/
;


parameter

p(i)    "Production of region i (million cubic feet / month)"
/
Canada           0
GOM              75679
Mexico           0
Midwest          16239
Mountain         525622
Northeast        837899
Pacific          17286
South_Central    1236835
Southeast        1283
/,

d(j)    "Demand of region j (million cubic feet / month)"
/
Canada           0
LNG_Export       0
Mexico           0
Midwest          655489
Mountain         215297
Northeast        743021
Pacific          278977
South_Central    672079
Southeast        269081
/,

r(j)    "Price of natural gas in region j (USD / million cubic feet)"
/
Canada           2.50
LNG_Export       8.00
Mexico           3.00
Midwest          3.50
Mountain         3.00
Northeast        3.50
Pacific          4.00
South_Central    2.50
Southeast        3.00
/;

table t(i,j)  "Transport cost from region i to region j (USD / million cubic feet)"
$ondelim
$include data\transportcosts1.csv
$offdelim
;

table k(i,j)  "Pipeline capacity from region i to region j (million cubic feet / month)"
$ondelim
$include data\regioncapacity1.csv
$offdelim
;


positive Variables
X(i,j)   "Volume of gas transported from region i to j (million cubic feet / month)",
Y        "total transportation costs (USD)"
S(j)     "total supply in region j"
;


Variables
Z        "total profits earned by natural gas industry",
C(j)     "Consumption of region j (million cubic feet / month)";

Equations
ObjFn            "computed objective function value",
TrCost           "total system transportation costs",
ConsLim(j)       "limit consumption by demand"
CapLim           "limit transport volume by pipeline capacity",
PrdLim(i)        "limit transport volume by region i production",
Supply(j)        "consumption in region j can't exceed 2supply in region j",
Demand(j)        "demand limit in region j"
;

*Signs that can be used in GAMS
**=e= -- equal to
**=g= -- greater than
**=l= -- less than

ObjFn..          Z =e= sum(j,C(j) * r(j)) - Y;

TrCost..         Y =e= sum((i,j),X(i,j) * t(i,j));

ConsLim(j)..     C(j) =l= d(j);

CapLim..         sum((i,j),X(i,j)) =l= sum((i,j),k(i,j));

PrdLim(i)..      sum(j,X(i,j)) =l= p(i);

Supply(j)..      sum(i,X(i,j)) =g= C(j);

Demand(j)..      d(j) =g= sum(i,X(i,j));

Model natgasmodel_v2 /all/;

solve natgasmodel_v2 using lp maximizing Z;




parameter rep, rep_regions;
rep("profit") =  sum(j,C.l(j) * r(j)) - sum((i,j),X.l(i,j) * t(i,j));

rep("revenue") = sum(j,C.l(j) * r(j));

rep("cost") = -sum((i,j),X.l(i,j) * t(i,j));

rep_regions(i,j) = X.l(i,j);

display rep, rep_regions;