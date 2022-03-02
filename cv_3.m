clc
clear
format long g

% Defining coordinates
phi_WGS = 50;
lam_WGS = 15;

[phi_B, lam_B] = WGStoJTSK(phi_WGS,lam_WGS)