function [T] = tem_trans(z)
    % tem_trans returns the temperature at given depth refer to reference
    % point
    % 
    % z: depth

    Tc  = 1900;  % unit: K
    z_c = 660;   % unit: km
    dT_z = 0.45; % adiabatic temperature  gradient, unit: K/km

    T = Tc + dT_z*(z-z_c);
end