function [G] = cal_G(P,T,flag_type)
    if flag_type == 1
        %Mg2SiO4
        dH = 27.1e+3;
        dS = -9;
        dV = -3.16e-6;
    else
        %Fe2SiO4
        dH = 9.6e+3;
        dS = -10.9;
        dV = -3.2e-6;
    end
    G = dH - T*dS +P*dV*10^9;
end