$onText
This model is intended to represent the US natural gas industry
through regional production and consumption, including pipeline
imports from Mexico and Canada and exports via pipeline to
Canada and Mexico as well as via LNG to non-adjacent countries.


Prepared by Andrew Moore for the Fall 2019 semester of EBGN 632
- Primary Fuels, taught by Ian Lange and Maxwell Brown at the
Colorado School of Mines.
$offText


set

i "producing regions"       /Canada, GOM, Mexico, Midwest, Mountain,
                            Northeast, Pacific, South Central, Southeast/,

j "consuming regions"       /Canada, LNG Export, GOM, Mexico, Midwest, Mountain,
                            Northeast, Pacific, South Central, Southeast/

;


parameter

p(i)    "Production of region i (million cubic feet / month)"

c(j)    "Consumption of region j (million cubic feet / month)"

r(j)    "Price of natural gas in region j (USD / million cubic feet)"

t(i,j)  "Transport cost from region i to region j (USD / million cubic feet)"

k(i,j)  "Pipeline capacity from region i to region j (million cubic feet / day)"

;

 

positive Variables

X(i,j)  "Volume of gas transported from region i to j (million cubic feet / day)",

Y       "total transportation costs (USD)"

;

 

Variables

Z       "total profits earned by natural gas industry";