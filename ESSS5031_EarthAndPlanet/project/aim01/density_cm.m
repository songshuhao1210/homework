%% calculate density by M and I

%% observation
M = 42828/6.67e-11;     % mass; kg
R = 3389;               % Mar's radius; km
I = 0.365*M*R^2;        % Mar's moment of inertia; kg*m^2

%% Assumptions
h = 100;                % crust thickness; km
R_cmb = 1830;           % core radius; km
rho_crust = 3000;       % crust density; kg/m^3

%% calculation
syms rho_core rho_mantle

f1 = M - 4/3*pi*rho_core * R_cmb^3 - 4/3*pi*rho_mantle * ( (R-h)^3-R_cmb^3 )...
    - 4/3*pi*rho_crust * ( R^3-(R-h)^3 );
f2 = I - 8/15*pi*rho_core * R_cmb^5 - 8/15*pi*rho_mantle * ((R-h)^5-R_cmb^5) ...
    - 8/15*pi*rho_crust * (R^5-(R-h)^5);
eqs = [f1==0,f2==0];
s =  solve(eqs,[rho_core,rho_mantle]);

disp(['rho_core = ',num2str(double(s.rho_core))])
disp(['rho_mantle = ',num2str(double(s.rho_mantle))])