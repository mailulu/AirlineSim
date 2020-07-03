$title wishmeluck


set
s simulated set of individuals /s1*s200/
n customers in scenario s /N1*n200/
f number of fare classes /f1*f5/
;

alias (f,k);
alias (n,m);

parameter
pitilde(f) upper bound of price for fare class f 
v(n,f,s) non-susceptible part of utility 
b(n,s) weight of cost of customer n in scenario s;

pitilde(f) / pitilde(f1) =l= pitilde(f2) =l= pitilde(f3) =l= pitilde(f4) /;


v(n,f,s)  *can be display as table
table tab(n,f,s) Eine Tabelle mit 3 Dimensionen



b(n,s)//;

scalar
c total seat capacity /10/
m1 big number /100/
m2 big number /100/;

positive variables
pi(n,f,s) price paid by customer n if fare class f is chosen in scenario s
z(f) cost(price) of fare class f
l(f) booking limit of fare class f
u(n,f,s) utility individual n receives from choosing fare class f in s
utilde(n,s) maximum utility value for individual n in s;

binary variables
y(n,f,s) is a fare class in scenario s chosen by n?
x(n,f,s) is a fare class offered for customer n in scenario s?;

free variable
R objective value
;

equations
eq_revenue revenue to be maximized
eq_price 
eq_cost 
eq_utility 
eq_demand 
eq_limit 
;

eq_revenue..    r =e= sum((f,n,s),pi(n,f,s)*1/abs(s));
eq_price..      pi(n,f,s) =L=pitilde(f)*Y(n,f,s);
eq_cost..       pi(n,f,s) =L= z(f);
eq_utility..    u(n,f,s) =L= v(n,f,s)*x(n,f,s) - beta(n,s)*z(f)
                utilde(n,s) =G= u(n,f,s)  *could be rewritten as max(u(n,f,s)
                u~(n,s) =L= u(n,f,s) + m1*(1-y(n,f,s));
eq_demand..     sum(f,y(n,f,s)) =L= 1
                y(n,f,s) =L= x(n,f,s)
                x(n+1,f,s) =L= x(n,f,s);
                
eq_limit..      sum(n,f, y(n,f,s)) =L= L(k)
		        sum(n,f, y(n,f,s))=L= L(k)-M2*X(m+1,k,s);

model wishmeluck /all/;

solve wishmeluck using lp maximizing r;

display "solution values:";


