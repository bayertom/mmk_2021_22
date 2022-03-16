function [] = drawGlobeFace(ub, vb, R, u0, uk, vk, proj, umin, umax, vmin, vmax, Du, Dv, du, dv, smin)
% Create face of polyedral globe
    hold on
    axis equal

    % Convert boundary points from u, v to s,d
    [sb, db] = uv_to_sd(ub, vb, uk, vk);
    
    % Project boundary points
    [xb, yb] = proj(R, sb, db, u0);
    
    % Draw boundary points
    plot(xb, yb, 'r');
    
    % Create graticule 
    [XM,YM, XP,YP] = graticule(R, u0, uk, vk, proj, umin, umax, vmin, vmax, Du, Dv, du, dv);
    
    % Draw graticule
    plot(XM', YM', 'k');
    plot(XP', YP', 'k');
    
    % Draw continents
    drawContinents('continents\eur.txt',R, uk, vk, u0, smin, proj);
    drawContinents('continents\austr.txt',R, uk, vk, u0, smin, proj);
    drawContinents('continents\anta.txt',R, uk, vk, u0, smin, proj);
    drawContinents('continents\amer.txt',R, uk, vk, u0, smin, proj);
    
end
