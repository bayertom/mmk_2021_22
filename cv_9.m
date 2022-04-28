clc 
clear
format long g
axis equal

%Lambert conformal conic projection
R = 1;

%Geographic pole
uk = 45.9977;
vk = 91.2461;

%Points, northern and southern parallel 
u1 = 29.0686;
v1 = 84.6801;
u2 = 26.9423;
v2 = 83.8537;

%Transform [u,v] to s, d
[s1,d1] = uv_to_sd(u1, v1, uk, vk);
[s2,d2] = uv_to_sd(u2, v2, uk, vk);

%Convert to radians
s1_r = s1*pi/180
d1_r = d1*pi/180
s2_r = s2*pi/180
d2_r = d2*pi/180

%Calculate c-constant
c_nom = log10(cos(s1_r)) - log10(cos(s2_r))
c_den = log10(tan(s2_r/2 + pi/4)) - log10(tan(s1_r/2 + pi/4))
c = c_nom/c_den

%Calculate s0
s_0 = asin(c)*180/pi
s_0r = asin(c)

%Calculate rho0
ro0_nom = 2*R*cos(s_0r)*cos(s1_r)*(tan((s1_r/2)+pi/4))^c;
ro0_den = c*(cos(s_0r)*(tan(s_0r/2+pi/4))^c + cos(s1_r)*(tan(s1_r/2+pi/4))^c);
ro0= ro0_nom/ro0_den;

%Radius of northern/soutrhern parallels
ro1 = ro0 * (tan(s_0r/2 + pi/4))^c / (tan(s1_r/2 + pi/4))^c;
ro2 = ro0 * (tan(s_0r/2 + pi/4))^c / (tan(s2_r/2 + pi/4))^c;

%Local linear scales, northern/soutrhern parallels
mr1 = c*ro1/(R*cos(s1_r));
mr2 = c*ro2/(R*cos(s2_r));
mr0 = c*ro0/(R*cos(s_0r));

%Calculate nu
nu_1 = mr1 - 1;
nu_2 = mr2 - 1;
nu_0 = 1 - mr0;














