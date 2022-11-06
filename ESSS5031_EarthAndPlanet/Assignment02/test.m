flag_phase = 1;
Ti = 1000;

if flag_phase == 1
        alpha_0_Mg = 0.3034;
        alpha_0_Fe = 0.2386;
        alpha_1_Mg = 0.7422;
        alpha_1_Fe = 1.1530;
        alpha_2_Mg = -0.5381;
        alpha_2_Fe = -0.0518;
    elseif flag_phase == 2
        alpha_0_Mg = 0.2893;
        alpha_0_Fe = 0.2319;
        alpha_1_Mg = 0.5772;
        alpha_1_Fe = 0.7117;
        alpha_2_Mg = -0.8903;
        alpha_2_Fe = -0.2430;
    else
        alpha_0_Mg = 0.2497;
        alpha_0_Fe = 0.2697;
        alpha_1_Mg = 0.3639;
        alpha_1_Fe = 0;
        alpha_2_Mg = -0.6531;
        alpha_2_Fe = -0;
    end

    syms T a0 a1 a2
    alpha(T,a0,a1,a2) = a0*1e-4 + a1*1e-8*T + a2/T^2;
    int_alpha = int(alpha,T,[T0,Ti]);

    %% V0(T)
    alpah_Mg =double( int_alpha(alpha_0_Mg,alpha_1_Mg,alpha_2_Mg) );
    alpah_Fe =double( int_alpha(alpha_0_Fe,alpha_1_Fe,alpha_2_Fe) );   