clc
clear
hold on
axis equal

proj  = @gnomonic

%Test graticule
[XM, YM, XP, YP] = graticule(1, 0, 90, 0, proj, 30, 90, 0, 360, 10, 10, 1, 1);
plot(XM', YM', 'k');
plot(XP', YP', 'k');

%Test continents
drawContinents('continents\eur.txt', 1, 90, 0, 0, 30, proj);


