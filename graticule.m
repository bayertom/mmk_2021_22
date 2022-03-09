function [XM,YM, XP,YP] = graticule(R, u0, uk, vk, proj, umin, umax, vmin, vmax, Du, Dv, du, dv)

    % Create parallels
    i = 1
    for u = umin:Du:umax

        % Create parallel
        vp = vmin:dv:vmax;
        up = ones(1, length(vp))*u;

        % Convert to oblique aspect
        [sp, dp] = uv_to_sd(up, vp, uk, vk);

        % Project parallel
        [XP(i, :), YP(i, :)] = proj(R, sp, dp, u0);

        i = i + 1;
    end

    % Create meridians
    i = 1
    for v = vmin:Dv:vmax

        % Create meridian
        um = umin:du:umax;
        vm = ones(1, length(um))*v;

        % Convert to oblique aspect
        [sm, dm] = uv_to_sd(um, vm, uk, vk);

        % Project meridian
        [XM(i, :), YM(i, :)] = proj(R, sm, dm, u0);

        i = i + 1;
    end

end