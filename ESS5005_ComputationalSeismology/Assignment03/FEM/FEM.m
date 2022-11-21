%% Heat diffussion by FEM
%
% Code by SONG Shuhao
%

%% parameter settings
ka = 0.019;    % kappa
Nx = 5;    % number of points per row
Ny = 5;    % number of points per column
dx = 0.1;    % length per node
eps = 0.1;  % e = kappa * dt / dx^2

flag_grid = 3; % 3--tri; 4--square
flag_plot_grid = 1; % 1--plot; 0--no plot
flag_pde_format = 2; % 1--explicit, 2--implicit

Nt = floor(1./eps*Nx);

N_tot = Nx*Ny;
Lx = (Nx-1)*dx;   % length of x
Ly = (Ny-1)*dx;   % length of y

dt = eps*dx^2 / ka; % time step
%% output

if flag_grid == 3
    path = 'output_tri/';
    filename =  'heatdiff_tri';
else
    path = 'output_sqr/';
    filename =  'heatdiff_sqr';
end

if exist(path) == 0
    mkdir(path)
end

%% create mass and stiff matrix M and D
if flag_grid == 3
    [M,D] = tri_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);
else
    [M,D] = sqr_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);
end


%% iteration
xita = solve_inv(M,D,ka,Nx,Ny,N_tot,eps,dx,flag_pde_format);

%% plot
plot_main(xita,dx,Lx,Ly,dt,Nt,path,filename)
