function [X Y] = sinu(R, u, v ,u0)
    %Sinusoidal projection
    u = u * pi / 180;
    v = v * pi /180;
    X = R*v.*cos(u);
    Y = R*u;
end
