clc
clear
format long g
axis equal

% Define extent
umin = -80;
umax = 80;
vmin = -180;
vmax = 180;

% umin = 50;
% umax = 50;
% vmin = 15;
% vmax = 15;

%Define steps
Du = 10;
Dv = 10;
dv = Dv/10;
du = Du/10;

R = 6380;

%Grid
[u, v] = meshgrid(umin:Du:umax, vmin:Dv:vmax);

%Convert to radians
ur = u * pi /180;
vr = v * pi /180;

%Distortions
mp = sqrt((vr.*sin(ur)).^2 + 1);
mr = 1;
p = -2*vr.*sin(ur);
A1 = atan2(-2, vr.*sin(ur))/2;
A2 = A1 + pi/2;

%Tissote indicatrix
a2 = mp.^2.*(cos(A1)).^2 + mr.^2*(sin(A1)).^2 + p.*sin(A1).*cos(A1);
b2 = mp.^2.*(cos(A2)).^2 + mr.^2*(sin(A2)).^2 + p.*sin(A2).*cos(A2);
a = max(sqrt(a2), sqrt(b2));
b = min(sqrt(a2), sqrt(b2));

%Airy + complex local
h2a = ((a-1).^2+(b-1).^2)/2;
h2c = (abs(a-1) + abs(b-1))/2 + a./b - 1;

%Airy global, non-weighted
H2A = mean(h2a(:));
H2C = mean(h2c(:));
HA = sqrt(H2A);
HC = sqrt(H2C);

%Airy global, weighted
W = cos(ur)
H2AN = W.*h2a;
H2AW = sum(H2AN(:))/sum(W(:));
HAW = sqrt(H2AW);

H2CN = W.*h2c;
H2CW = sum(H2CN(:))/sum(W(:));
HCW = sqrt(H2CW);

%Create graticule and plot
proj = @sinu
uk = 90;
vk = 0;
[XM,YM, XP,YP] = graticule(R, 0, uk, vk, proj, umin, umax, vmin, vmax, Du, Dv, du, dv);
    
% Draw graticule
hold on
plot(XM', YM', 'k');
plot(XP', YP', 'k');
    
% Draw continents
drawContinents('continents\eur.txt',R, uk, vk, 0, -90, proj);
drawContinents('continents\austr.txt',R, uk, vk, 0, -90, proj);
drawContinents('continents\anta.txt',R, uk, vk, 0, -90, proj);
drawContinents('continents\amer.txt',R, uk, vk, 0, -90, proj);

%Compute XY of grid points
[X,Y] = proj(R, u, v, 0);

%Map scale
M = 100000000;
Muv = M./a;

%Contour lines
[C, h] = contour(X, Y, Muv, [20000000:10000000:300000000], 'LineColor', 'r', 'LineWidth' ,2);
clabel(C, h, 'Color', 'r', 'labelspacing', 1000)



