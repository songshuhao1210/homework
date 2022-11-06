function [rho_EoS,rho_mine] = cal_rho(flag_phase,z,P)
    % cal_rho.m returns the rho calculated by Birch-Murnaghan EoS and
    % mineral composition, respectively
    
    %% parameters
    M_Mg = 140;     % Molar Mass of Mg2SiO4
    M_Fe = 204;     % Molar Mass of Fe2SiO4
    X_Mg = 0.9;     % fraction of Mg
    X_Fe = 0.1;     % fraction of Fe

    Ti = tem_trans(z);  % temperature of this depth
    %% calculate by mineral composition
    [V0_Mg,V0_Fe,KT0_T,V0_T,gama] = int_paras(flag_phase,Ti,X_Mg,X_Fe);

    M = X_Mg*M_Mg+X_Fe*M_Fe ;
    V = X_Mg*V0_Mg+X_Fe*V0_Fe;

    rho_mine =  M / V;

    %% calculate by Birch-Murnaghan EoS
    syms x
%     y = P - 3/2*KT0_T*( (V0_T/M*x)^(7/3) - (V0_T/M*x)^(5/3) )*...
%         (1+gama*((V0_T/M*x)^(2/3)-1));
    y  = P - 3/2*KT0_T*(x^(7)-x^(5)) * (1+gama*(x^(2)-1));
    
    mid_para = double(solve(y,x,'Real',true));
    mid_para = mid_para(mid_para>0);

    rho_EoS = M*mid_para^(3)/V0_T;

end