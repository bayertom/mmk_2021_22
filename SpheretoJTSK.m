function [X,Y] = SpheretoJTSK(u, v)

% Conversion to oblique aspect
uk = 59 + 42/60 + 42.6969/3600;
vk = 42 + 31/60 + 31.41725/3600;

%Ferro
v = v + 17 + 2/3;

[s, d] = uv_to_sd (u, v, uk, vk);
sr = s * pi/180;
dr = d * pi/180;

% Lambert conformal conic projection
R_g = 6380703.61050963;
s_0 = 78.50 * pi/180;
c = sin(s_0);
ro_0 = 0.9999 * R_g * cot(s_0);
ro = ro_0 * ((tan(s_0/2+pi/4))/(tan(sr/2+pi/4)))^c;
eps = c*dr;

% Polar to ortogonal
X = ro*cos(eps);
Y = ro*sin(eps);




















