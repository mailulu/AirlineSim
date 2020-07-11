$title choice-based revnue Management Model

set
s scenarios /s1*s2/
n number of p /n1/
f number of fare classes /f1*f5/

;

alias (n,m);
alias (f,k);


parameter

ub(f) 'upper bound price'
/ f1 = 1 /
    
    
v(n,f,s) 'deterministic utility'
    / n1 .f1 .s1 = 1
    n1 .f2 .s1 = 2
    n1 .f3 .s1 = 3
    n1 .f4 .s1 = 4
    n1 .f5 .s1 = 0
    n1 .f1 .s2 = 4
    n1 .f2 .s2 = 3
    n1 .f3 .s2 = 2
    n1 .f4 .s2 = 1
    n1 .f5 .s2 = 0 /

b(n,s) 'weight of cost of customer n in scenario s'
/  n1 .s1 = 1
   n1 .s2 = 0 /;

scalar
c total seat capacity /5/
m1 big number /100/
m2 big number /100/;

positive variables
pi(n,f,s) price paid by customer n if fare class f is chosen in scenario s
z(f) cost(price) of fare class f
l(f) booking limit of fare class f
u(n,f,s) utility individual n receives from choosing fare class f in s
ud(n,s) maximum utility value for individual n in s
;

binary variables
y(n,f,s) is a fare class in scenario s chosen by n?
x(n,f,s) is a fare class offered for customer n in scenario s?;

free variable
obj objective value
;
equations
eq_revenue define objective function
eq_revenue1 
eq_price(n,f,s) price is less than or equal to upperbound of price *to stay in fareclass
eq_cost(n,f,s) price is less than or equal to cost(price) of fare class
eq_utility(n,f,s) utility is equal to
eq_utility1(n,f,s)
eq_utility2(n,f,s)
eq_demand(n,s)
eq_demand1(n,f,s) 
eq_demand2(n,f,s) 
eq_limit(k)
eq_limit1(k,m)
;




eq_revenue..  obj =e= sum((f,n,s),pi(n,f,s))/1;
eq_revenue1..  obj =e= sum((f,n,s),pi(n,f,s))/2;

eq_price(n,f,s)..      pi(n,f,s) =L= ub(f)*Y(n,f,s);
eq_cost(n,f,s)..       pi(n,f,s) =L= z(f);
eq_utility (n,f,s)..    u(n,f,s) =e= v(n,f,s)*x(n,f,s) - b(n,s)*z(f)
eq_utility1 (n,f,s)..   ud(n,s) =G= u(n,f,s)  
eq_utility2 (n,f,s)..   ud(n,s) =L= u(n,f,s) + m1*(1-y(n,f,s));
eq_demand(n,s)..     sum(f,y(n,f,s)) =L= 1
eq_demand1(n,f,s)     y(n,f,s) =L= x(n,f,s)
eq_demand2(n,f,s)     x(n+1,f,s) =L= x(n,f,s) ;
                
eq_limit(k)..      sum((n,f,s),y(n,f,s)) =L= L(k)
eq_limit1(k,m)..	        sum(n,f,y(n,f,s))=L= L(k)-M2*X(m+1,k,s);
