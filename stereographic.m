function [X, Y] = stereographic(R, s, d, s0)
psi_0 = 90 - s0;
psi_0r = psi_0 * pi/180;

c = 2*R*(cos(psi_0r/2))^2;

psi = 90-s;
psi_r = psi * pi/180;

ro = c * tan(psi_r/2);
eps = d;
eps_r = eps * pi /180;


X = ro .* sin(eps_r);
Y = -ro .* cos(eps_r);