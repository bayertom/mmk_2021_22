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


