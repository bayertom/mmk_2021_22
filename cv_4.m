clc
clear
hold on
axis equal

%proj  = @gnomonic

%Test graticule
%[XM, YM, XP, YP] = graticule(1, 0, 90, 0, proj, 30, 90, 0, 360, 10, 10, 1, 1);
%plot(XM', YM', 'k');
%plot(XP', YP', 'k');

%Test continents
%drawContinents('continents\eur.txt', 1, 90, 0, 0, 30, proj);
%drawContinents('continents\austr.txt', 1, 90, 0, 0, 30, proj);
%drawContinents('continents\anta.txt', 1, 90, 0, 0, 30, proj);
%drawContinents('continents\amer.txt', 1, 90, 0, 0, 30, proj);

%Input parameters
R = 1;
u0 = 0;
proj = @gnomonic;
Du = 10;
Dv = 10;
du = 1;
dv = 1;
smin = 10;
us =  35.2644;
uj = -us;
xmin = -2;
xmax = 2;
ymin = xmin;
ymax = xmax;

%Face 1 (nothern)
ub = [us, us, us, us, us];
vb = [0, 90, 180, 270, 0];
umin = 30;
umax = 90;
vmin = -180;
vmax = 180;
uk = 90;
vk = 0;

subplot(2, 3, 1);
drawGlobeFace(ub, vb, R, u0, uk, vk, proj, umin, umax, vmin, vmax, Du, Dv, du, dv, smin);

%Face 2 ()
ub = [us, uj, uj, us, us];
vb = [0, 0, 90, 90, 0];
umin = -40;
umax = 40;
vmin = -10;
vmax = 100;
uk = 0;
vk = 45;

subplot(2, 3, 2);
drawGlobeFace(ub, vb, R, u0, uk, vk, proj, umin, umax, vmin, vmax, Du, Dv, du, dv, smin);

%Set limits
subplot(2, 3, 1);
xlim([xmin, xmax]);
ylim([ymin, ymax]);

subplot(2, 3, 2);
xlim([xmin, xmax]);
ylim([ymin, ymax]);


