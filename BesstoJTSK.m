function [X,Y] = BesstoJTSK(phi_B,lam_B)

% Convert to radians
phir_B = phi_B*pi/180;
lamr_B = lam_B*pi/180;

% Bessels ellipsoid
a_B = 6377397.155;
b_B = 6356078.963;

% Excentricity of Bessels ellipsoid
e2_B = (a_B*a_B - b_B*b_B)/(a_B*a_B);

% (lat, lon)_Bess -> (u, v)_sphere
lam_F_deg = lam_B + 17 + 2/3;
lamr_F = lam_F_deg * pi/180;
phi_0 = 49.5 * pi/180;

%Constant values
alpha = sqrt(1 + e2_B * (cos(phi_0))^4/(1 - e2_B));
u_0=asin(sin(phi_0)/alpha);
k_c=(tan(phi_0/2+pi/4)^alpha*((1-sqrt(e2_B)*sin(phi_0))/...
    (1+sqrt(e2_B)*sin(phi_0)))^(alpha*sqrt(e2_B)/2));
k_j=tan(u_0/2+pi/4);
k=k_c/k_j;
R_g = (a_B*sqrt(1-e2_B))/(1-e2_B*(sin(phi_0))^2);

%Gaussian conformal projection
u_r =((tan(phir_B/2 + pi/4)*((1-sqrt(e2_B)*sin(phir_B))/...
    (1+sqrt(e2_B)*sin(phir_B)))^(sqrt(e2_B)/2))^alpha)/k;
u = 2*atan(u_r)-pi/2;
u_deg = u * 180/pi;
v = alpha*lamr_F;
v_deg = v * 180/pi;

% Conversion to oblique aspect
uk = 59 + 42/60 + 42.6969/3600;
vk = 42 + 31/60 + 31.41725/3600;

[s, d] = uv_to_sd (u_deg, v_deg, uk, vk);
sr = s * pi/180;
dr = d * pi/180;

% Lambert conformal conic projection
s_0 = 78.50 * pi/180;
c = sin(s_0);
ro_0 = 0.9999 * R_g * cot(s_0);
ro = ro_0 * ((tan(s_0/2+pi/4))/(tan(sr/2+pi/4)))^c;
eps = c*dr;

% Polar to ortogonal
X = ro*cos(eps);
Y = ro*sin(eps);




















