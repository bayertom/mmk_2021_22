function [X,Y] = WGStoJTSK(phi,lam)

% Degrees to Radians
phir = phi*pi/180;
lamr = lam*pi/180;

% Elipsoid WGS 84
a_WGS = 6378137;
b_WGS = 6356752.3142;

% Parameters of WGS 84
e2_WGS = (a_WGS*a_WGS - b_WGS*b_WGS)/(a_WGS*a_WGS);
W_WGS = sqrt(1-e2_WGS*(sin(phir)).^2);
N_WGS = a_WGS/W_WGS;

% Geocentric coordinates
X_WGS = N_WGS*cos(phir)*cos(lamr);
Y_WGS = N_WGS*cos(phir)*sin(lamr);
Z_WGS = N_WGS*(1-e2_WGS)*sin(phir);

% Parameters of Helmert transformation
w_x = 4.9984/3600*pi/180;
w_y = 1.5867/3600*pi/180;
w_z = 5.2611/3600*pi/180;
d_x = -570.8285
d_y = -85.6769
d_z = -462.8420
m = 1 - 3.5623e-6

% Rotation matrix
R = [1 w_z -w_y; -w_z 1 w_x; w_y -w_x 1];

% WGS coordinates matrix
XYZ_WGS = [X_WGS; Y_WGS; Z_WGS];

% Shift matrix
D =  [d_x; d_y; d_z];

% Helmert transformation
XYZ_B = m * R * XYZ_WGS + D;
X_B = XYZ_B(1, 1);
Y_B = XYZ_B(2, 1);
Z_B = XYZ_B(3, 1);

% Bessels ellipsoid
a_B = 6377397.155;
b_B = 6356078.963;

% Excentricity of Bessels ellipsoid
e2_B = (a_B*a_B - b_B*b_B)/(a_B*a_B);

% Longitude - Bessel ellipsoid
lamr_B = atan2(Y_B,X_B);
lam_B = lamr_B*180/pi;

% Latitude - Bessel ellipsoid
phir_B = atan2(Z_B, (1-e2_B)*sqrt(X_B*X_B+Y_B*Y_B));
phi_B = phir_B*180/pi;

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
ukr = uk * pi/180;
vkr = vk * pi/180;

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

% Local linear scale
mr_0 = c*ro_0/(R_g*cos(s_0));
mr = c*ro/(R_g*cos(sr));
dro = (ro-ro_0)/100000;
mrs = 0.9999 + 0.00012282 * dro^2 - 0.00000315*dro^3 + 0.00000018*dro^4;


% Distortion
nu_0 = (mr_0 - 1)*1000;
nu = (mr - 1)*1000;
nus = (mrs - 1)*1000;

%Convergence
ksi = asin((cos(ukr) * sin(dr))/ cos(u));
conr = eps - ksi;
con = conr * 180/pi;
con2 = 0.008257 * Y/1000 + 2.373 * Y/X;









