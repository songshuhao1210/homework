% mass to mole composition transformation

%% mass composition
w_core = [86, 5.5, 6.8, 1.7];               % Fe, Ni, Si, O
w_mantle = [45.5, 38.3, 8.2, 4.5, 3.5];     % SiO2, MgO, FeO, Al2O3, CaO

M_core = [56, 59, 28, 16];          % Fe, Ni, Si, O
M_mantle = [60, 40, 72, 100, 56];   % SiO2, MgO, FeO, Al2O3, CaO

%% total mole number
n_core = 0;
n_mantle = 0;
x_core = zeros(length(w_core),1);
x_mantle = zeros(length(w_mantle),1);
for i = 1:length(w_core)
    x_core(i) = w_core(i)/M_core(i);
    n_core = n_core + x_core(i);
end
for i = 1:length(w_mantle)
    x_mantle(i) = w_mantle(i)/M_mantle(i);
    n_mantle = n_mantle + x_mantle(i);
end

%% mole composition
x_core = x_core/n_core;
x_mantle = x_mantle/n_mantle;

%% calculate equilibrium eqs and fugacity
K = x_mantle(3)/sqrt(x_core(4))/x_core(1);
disp(['Chemical equilibrium equations is: ',num2str(K)])

P0 = 1; % bar
f = P0/K^2;
disp(['Fugacity = ',num2str(f),' bar'])