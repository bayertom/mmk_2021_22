clc 
clear
format long g
axis equal

R = 1;

%Stereographic projection
vk = 84.2326;
uk = 28.2016;

% Point on the boundary circle
v1 = 81.736;
u1 = 31.6378;

%Transform [u,v] to s, d
[s, d] = uv_to_sd(u1, v1, uk, vk);

%Reduced angle
psi = 90 - s;
psi_r = psi * pi/180;

%Multiplicative constant
mju = (2*cos(psi_r/2)*cos(psi_r/2))/(1+cos(psi_r/2)*cos(psi_r/2));

%True parallel
psi_0r = 2 * acos(sqrt(mju));
psi_0 = psi_0r * 180/pi;
s_0r = pi/2 - psi_0r;
s_0 = s_0r * 180/pi;

%Local linear scales, northern/mid/southern parallel
mr1 = mju/((cos(0))^2);
mr0 = mju/((cos(psi_0r/2))^2);
mr2 = mju/((cos(psi_r/2))^2);

%Calculate nu
nu_1 = mr1 - 1;
nu_2 = mr2 - 1;
nu_0 = 1 - mr0;

%Create graticule
umin = 26;
umax = 31;
vmin = 80;
vmax = 89;
Du = 1;
Dv = 1;
du = Du/10;
dv = Dv/10;
proj = @stereographic;
[XM,YM, XP,YP] = graticule(R, s_0, uk, vk, proj, umin, umax, vmin, vmax, Du, Dv, du, dv);

hold on
plot(XM', YM', 'k');
plot(XP', YP', 'k');

%Create meshgrid of points
[u,v] = meshgrid(umin:du:umax, vmin:dv:vmax);

%Transform [u,v] to s, d
[s,d] = uv_to_sd(u, v, uk, vk);

%Compute stereographic projection
[X, Y] = stereographic(R, s, d, s_0);

% Local linear scale and distortion
psi = 90 - s;
psi_r = psi * pi / 180;
m = mju ./ cos(psi_r/2).^2;
nu = (m - 1)*1000;

%Contour lines
[C, h] = contour(X, Y, nu, [-1:0.1:1], 'LineColor', 'r');
clabel(C, h, 'Color', 'r');

%Draw Nepali
nepal=load('nepal.txt');
un = nepal(:,1);
vn = nepal(:,2);

%Transform [u,v] to s, d
[sn,dn] = uv_to_sd(un,vn,uk,vk);

%Compute stereographic projection
[Xn, Yn] = stereographic(R, sn, dn, s_0);
plot(Xn', Yn', 'k', 'LineWidth', 2);













