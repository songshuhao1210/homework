function [V0_Mg,V0_Fe,KT0_T,V0_T,gama] = int_paras(flag_phase,Ti,X_Mg,X_Fe)
    % paras.m returns useful parameters used during calculation for
    % different minerals

    %% calculate alpha
    if flag_phase == 1
        alpha_0_Mg = 0.3034;
        alpha_0_Fe = 0.2386;
        alpha_1_Mg = 0.7422;
        alpha_1_Fe = 1.1530;
        alpha_2_Mg = -0.5381;
        alpha_2_Fe = -0.0518;

        V0_Mg = 43.6; % cm^3/mol
        V0_Fe = 46.29;

        KT0_Mg = 129;   % GPa
        KT0_Fe = 137.9; % GPa 

        KT0_dT_Mg = -0.0224;    % GPa/K
        KT0_dT_Fe = -0.0258;    % GPa/K 

        KT_diff_Mg = 5.37; % KT'
        KT_diff_Fe = 4.00; % KT'
    elseif flag_phase == 2
        alpha_0_Mg = 0.2893;
        alpha_0_Fe = 0.2319;
        alpha_1_Mg = 0.5772;
        alpha_1_Fe = 0.7117;
        alpha_2_Mg = -0.8903;
        alpha_2_Fe = -0.2430;

        V0_Mg = 40.52; % cm^3/mol
        V0_Fe = 43.15;

        KT0_Mg = 174;   % GPa
        KT0_Fe = 166;   % GPa 

        KT0_dT_Mg = -0.0323;    % GPa/K
        KT0_dT_Fe = -0.0215;    % GPa/K 

        KT_diff_Mg = 4.00; % KT'
        KT_diff_Fe = 4.00; % KT'
    else
        alpha_0_Mg = 0.2497;
        alpha_0_Fe = 0.2697;
        alpha_1_Mg = 0.3639;
        alpha_1_Fe = 0;
        alpha_2_Mg = -0.6531;
        alpha_2_Fe = -0;

        V0_Mg = 39.49; % cm^3/mol
        V0_Fe = 42.03;

        KT0_Mg = 183;   % GPa
        KT0_Fe = 197;   % GPa 

        KT0_dT_Mg = -0.0348;    % GPa/K
        KT0_dT_Fe = -0.0375;    % GPa/K 

        KT_diff_Mg = 4.30; % KT'
        KT_diff_Fe = 4.00; % KT'
    end

    T0 = 1900;  % K

    syms T a0 a1 a2
    alpha(T,a0,a1,a2) = a0*1e-4 + a1*1e-8*T + a2/T^2;
    int_alpha = int(alpha,T,[T0,Ti]);

    %% V0(T)
    int_alpah_Mg =double( int_alpha(alpha_0_Mg,alpha_1_Mg,alpha_2_Mg) );
    int_alpah_Fe =double( int_alpha(alpha_0_Fe,alpha_1_Fe,alpha_2_Fe) ); 

    V0_T = X_Mg*V0_Mg*exp(int_alpah_Mg) + X_Fe*V0_Fe*exp(int_alpah_Fe);

    %% KT0(T)
    KT0_T = X_Fe*KT0_Fe+X_Mg*KT0_Mg+...
        (X_Mg*KT0_dT_Mg+X_Fe*KT0_dT_Fe)*(Ti-T0);

    %% KT'
    KT_diff = X_Mg*KT_diff_Mg + X_Fe*KT_diff_Fe;

    gama = 3/4*(KT_diff-4);


end