%% calculate density by M and I

%% observation
M = 42828/6.67e-11;     % mass; 
R = 3389;               % Mar's radius; km
I = 0.365*M*R^2;        % Mar's moment of inertia;

%% Assumptions
h = 100;                % crust thickness; km
R_cmb = 1830;           % core radius; km
%rho_mantle = 3000;       % crust density; kg/m^3

I1 = 37216900816828.64;
I2 = 2.7328079130595977e+20;
%% calculation
syms rho_core rho_crust

data = load("DW_1.tab");
rho = data(:,3)';
rr_m = 3288:-1:1830;

I1 = -4*pi*trapz(rr_m,rho.*rr_m.^2);
I2 = -8/3*pi*trapz(rr_m,rho.*rr_m.^4);

f1 = M - 4/3*pi*rho_core * R_cmb^3 - I1...
    - 4/3*pi*rho_crust * ( R^3-(R-h)^3 );
f2 = I - 8/15*pi*rho_core * R_cmb^5 - I2 ...
    - 8/15*pi*rho_crust * (R^5-(R-h)^5);
eqs = [f1==0,f2==0];
s =  solve(eqs,[rho_core,rho_crust]);

disp(['rho_core = ',num2str(double(s.rho_core))])
disp(['rho_mantle = ',num2str(double(s.rho_crust))])