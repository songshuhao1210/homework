%% Heat diffussion by FEM
%
% Code by SONG Shuhao
%

%% parameter settings
ka = 0.012;    % kappa
Nx = 5;    % number of points per row
Ny = 5;    % number of points per column
dx = 1;    % length per node
eps = 1;  % e = kappa * dt / dx^2

flag_grid = 3; % 3--tri; 4--square
flag_plot_grid = 1; % 1--plot; 0--no plot

Nt = floor(20/eps);

N_tot = Nx*Ny;
Lx = (Nx-1)*dx;   % length of x
Ly = (Ny-1)*dx;   % length of y

%% output
path = 'output_tri/';
filename =  'heatdiff_tri';
if exist(path) == 0
    mkdir(path)
end

%% create mass and stiff matrix M and D
[M,D] = tri_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);


%% create source term R
%R = R_vec(Nx,Ny,N_tot,dx,ka,xita_old);
R = sparse(N_tot,1);

%% iteration
xita = solve_inv(M,D,R,ka,Nt,Nx,Ny,N_tot,eps,dx);

%% plot
plot_main(xita,dx,Lx,Ly,dt,Nt,path,filename)
