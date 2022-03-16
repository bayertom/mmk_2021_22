function [] = drawContinents(file, R, uk, vk, u0, smin, proj)
    % Load data
    f = load(file);
    u = f(:,1);
    v = f(:,2);

    % Convert u, v to s, d
    [s, d] = uv_to_sd(u, v, uk, vk);

    % Remove points southern than smin
    idx = find(s < smin);
    s(idx) = []; d(idx) = [];


    % Project
    [x, y] = proj(R, s, d, u0);
    
    % Draw continents
    plot(x, y, 'b', 'LineWidth', 2);

  

 