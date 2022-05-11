clc
clear

format long g
axis equal

% Define extent
umin = -80;
umax = 80;
vmin = -180;
vmax = 180;
Du = 10;
Dv = 10;
dv = Dv/10;
du = Du/10;

R = 6380;

%Load graticule points
P = load("points_sinu.txt");
u = P(:, 1);
x = P(:, 3);
y = P(:, 4);
a = P(:, 5);
b = P(:, 6);

%Create W matrix
W = cos(u*pi/180);

%Airy + complex local
h2a = ((a-1).^2+(b-1).^2)/2;
h2c = (abs(a-1) + abs(b-1))/2 + a./b - 1;

%Airy global, non-weighted
H2A = mean(h2a(:));
H2C = mean(h2c(:));
HA = sqrt(H2A);
HC = sqrt(H2C);

%Airy global, weighted
H2AN = W.*h2a;
H2AW = sum(H2AN(:))/sum(W(:));
HAW = sqrt(H2AW);

H2CN = W.*h2c;
H2CW = sum(H2CN(:))/sum(W(:));
HCW = sqrt(H2CW);

%Load meridians
M = load('meridians_sinu.txt');
xm = M(:, 3);
ym = M(:, 4);

%Load parallels
P = load('parallels_sinu.txt');
xp = P(:, 3);
yp = P(:, 4);

%Load contients
EU = load('europe_sinu.txt');
xeu = EU(:, 3);
yeu = EU(:, 4);

%Draw meridians
hold on
nm = length(umin:du:umax)
for i = 1:nm:length(xm)
    plot(xm(i:i+nm - 1), ym(i:i+nm - 1), 'k');
end

%Draw parallels
np = length(vmin:dv:vmax)
for i = 1:np:length(xp)
    plot(xp(i:i+np - 1), yp(i:i+np - 1), 'k');
end
    
%Draw continents
plot(xeu, yeu, 'b');

%Map scale
M = 100000000;
Muv = M./a;

%Convert [x,y,M] to meshgrid
xg = linspace(min(x), max(x), 100);
yg = linspace(min(y), max(y), 100);
[X,Y] = meshgrid(xg, yg);
Z = griddata(x, y, Muv, X, Y, 'cubic');

%Draw contour lines
[C, h] = contour(X, Y, Z, [20000000:10000000:300000000], 'LineColor', 'r', 'LineWidth' ,2);
clabel(C, h, 'Color', 'r', 'labelspacing', 1000)