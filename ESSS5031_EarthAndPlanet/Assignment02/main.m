% Assignment 02 Thermodynamics and Equations of State

% parameters:
flag_phase = 1; % 1--Olivine, 2--beta phase, 3--Spinel
z_1= 355;         % km
P_1 = 11.7702;    % GPa

z_2 = 450;
P_2 = 15.2251;

[rho_EoS_Oli_1,rho_mine_Oli_1] = cal_rho(1,z_1,P_1);
[rho_EoS_beta_1,rho_mine_beta_1] = cal_rho(2,z_1,P_1);
[rho_EoS_Spi_1,rho_mine_Spi_1] = cal_rho(3,z_1,P_1);

[rho_EoS_Oli_2,rho_mine_Oli_2] = cal_rho(1,z_2,P_2);
[rho_EoS_beta_2,rho_mine_beta_2] = cal_rho(2,z_2,P_2);
[rho_EoS_Spi_2,rho_mine_Spi_2] = cal_rho(3,z_2,P_2);


contrast = (rho_EoS_beta_2-rho_EoS_Oli_1)/rho_EoS_Oli_1