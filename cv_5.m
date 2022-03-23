syms R u v

%Gnomonic projection
x=R*tan(pi/2 - u)*cos(v)
y=R*tan(pi/2 - u)*sin(v)

%Partial derivatives
fu = diff(x, u);
fu = simplify(fu, 'Steps', 20);
fv = simplify(diff(x, v), 'Steps', 20);
gu = simplify(diff(y, u), 'Steps', 20);
gv = simplify(diff(y, v), 'Steps', 20);

%Local linear scales
mp2 = simplify((fu*fu+gu*gu)/(R*R))
mr2 = simplify((fv^2 + gv^2)/(R*cos(u))^2)

