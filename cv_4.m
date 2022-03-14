clc
clear
hold on

proj  = @gnomonic

[XM, YM, XP, YP] = graticule(6380, 0, 90, 0, proj, 60, 90, 0, 360, 10, 10, 1, 1);
plot(XM', YM');
plot(XP', YP');

