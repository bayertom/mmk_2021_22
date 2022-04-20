function [s, d] = uv_to_sd(u, v, uk, vk)

    %Convert degrees to radians
    ur = u*pi/180;
    vr = v*pi/180;
    ukr = uk*pi/180;
    vkr = vk*pi/180;

    % Longitude difference
    dv = vkr-vr;

    % Transform latitude 
    s = asin(sin(ur).*sin(ukr) + cos(ur).*cos(ukr).*cos(dv)).*180/pi;

    % Transform longitude
    num = cos(ur).*sin(dv);
    dnom = cos(ur).*sin(ukr).*cos(dv)-sin(ur).*cos(ukr);

    d = atan2(num,dnom)*180/pi;
    %d = -d;
    
end


