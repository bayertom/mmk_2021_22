clc
clear

% Quadrant I
u = 50;
v = 15;
uk = 60;
vk = 20;

[s1,d1] = uv_to_sd(u, v, uk, vk)

% Quadrant II
uk = 40;

[s2,d2] = uv_to_sd(u, v, uk, vk)

% Quadrant III
vk = 10;

[s3,d3] = uv_to_sd(u, v, uk, vk)

% Quadrant IV
uk = 60;
[s4,d4] = uv_to_sd(u, v, uk, vk)

%Batch conversion
u = [50 52 54 60];
v = [15 17 10 11];
[s,d] = uv_to_sd(u, v, uk, vk)
