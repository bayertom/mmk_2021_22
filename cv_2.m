clc
clear
format long g

%Input points
fi_1 = 48.11;
lam_1 = 22.28;
fi_2 = 50.1;
lam_2 = 15.2;

%Wgs to jtsk
[x_1, y_1] = WGStoJTSK(fi_1, lam_1);
[x_2, y_2] = WGStoJTSK(fi_2, lam_2);
d1 = sqrt((x_2-x_1)^2+(y_2-y_1)^2);
sigma1 = atan2(y_2 - y_1, x_2 - x_1)*180/pi;

%Bessel to jtsk
[x_3, y_3] = BesstoJTSK(fi_1, lam_1);
[x_4, y_4] = BesstoJTSK(fi_2, lam_2);
d2 = sqrt((x_4-x_3)^2+(y_4-y_3)^2);
sigma2 = atan2(y_4 - y_3, x_4 - x_3)*180/pi;

%Sphere to jtsk
[x_5, y_5] = SpheretoJTSK(fi_1, lam_1);
[x_6, y_6] = SpheretoJTSK(fi_2, lam_2);
d3 = sqrt((x_6-x_5)^2+(y_6-y_5)^2);
sigma3 = atan2(y_6 - y_5, x_6 - x_5)*180/pi;
