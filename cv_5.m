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
mp2 = simplify((fu*fu+gu*gu)/(R*R));
mr2 = simplify((fv^2 + gv^2)/(R*cos(u))^2);
mp = simplify(sqrt(mp2));
mr = simplify(sqrt(mr2));

%Tissot indicatrix
p = 2*(fu*fv+gu*gv);
a = mp;
b = mr;

% Angle between projected meridian and parallel
omega_tan = simplify((gu*fv - fu*gv) / (p/2))
omega = atan(omega_tan)

% Maximal angular distortion
delta_omega_sin = simplify(abs(mp - mr) / (mp + mr));
delta_omega = asin(delta_omega_sin)*2

% Areal distortion
P = simplify((gu*fv - fu*gv)/(R*R*cos(u)));

% Meridian convergence
sigma_p = simplify(atan(gu / fu));
c = abs(sigma_p - pi/2)

%Numerical values
Rn = 1;
un = 35.2644 * pi/180;
vn = 0;

% Numeric values of partial derivations
fun = double(subs(fu, {R, u, v}, {Rn, un, vn}));
gun = double(subs(gu, {R, u, v}, {Rn, un, vn}));
fvn = double(subs(fv, {R, u, v}, {Rn, un, vn}));
gvn = double(subs(gv, {R, u, v}, {Rn, un, vn}));

%Local linear scales
mpn = double(subs(mp, {R, u, v}, {Rn, un, vn}));
mrn = double(subs(mr, {R, u, v}, {Rn, un, vn}));

% Angle between projected meridian and parallel, numerical value
omega_n = double(subs(omega, {R, u, v}, {Rn, un, vn}));

% Numerical value of maximal angular distortion
delta_omega_n = double(subs(delta_omega, {R, u, v}, {Rn, un, vn})) * 180/pi

% Numerical value of areal distortion
Pn = double(subs(P, {R, u, v}, {Rn, un, vn}));

% Direction
sigma_pn = double(subs(sigma_p, {R, u, v}, {Rn, un, vn}))

% Meridian convergence numerical value
cn = double(subs(c, {R, u, v}, {Rn, un, vn}))

%Create graticule
hold on
axis equal
[XM,YM, XP,YP] = graticule(Rn, 0, 90, 0, @gnomonic, 10, 90, 0, 360, 10, 10, 1, 1);
plot(XM', YM', 'k');
plot(XP', YP', 'k');

%Tissot indicatrix
t = 0:pi/45:pi*2;
X_e = 0.25 * mpn*cos(t);
Y_e = 0.25 * mrn*sin(t);

%Tissot indicatrix, rotate
X_er = X_e*cos(sigma_pn)- Y_e*sin(sigma_pn);
Y_er = X_e*sin(sigma_pn) + Y_e*cos(sigma_pn);

% Shift Tissot indicatrix
[x_p, y_p] = gnomonic(Rn, un*180/pi, vn*180/pi, 0);
X_es = X_er + x_p;
Y_es = Y_er + y_p;

plot(X_es, Y_es, 'b')










