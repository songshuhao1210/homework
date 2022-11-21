%% Heat diffussion by FEM
%
% Code by SONG Shuhao
%

%% parameter settings
eps = 0.01;  % e = kappa * dt / dx^2
Nx = 5;    % number of points per row
Ny = 5;    % number of points per column
dx = 0.1;    % length per node

flag_grid = 4; % 3--tri; 4--square
flag_pde_format = 1; % 1--explicit; 2--implicit

ka = 0.019;    % kappa  mm^2/s

[Nt,dt] = N_t(Nx,eps,ka,dx);
N_tot = Nx*Ny;
Lx = (Nx-1)*dx;   % length of x
Ly = (Ny-1)*dx;   % length of y
path_mat = 'M_D/';

%% output
path = 'output_test/';
if flag_grid == 3
    filename =  ['heatdiff_tri_eps_',num2str(eps)];
    filename_mat =  ['tri_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
else
    filename =  ['heatdiff_sqr_eps_',num2str(eps)];
    filename_mat =  ['sqr_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
end

if flag_pde_format == 1
    filename = [filename,'_explicit'];
else
    filename = [filename,'_implicit'];
end

if exist(path) == 0
    mkdir(path)
end

%% import M and D
filename_mat = [path_mat,filename_mat];
load(filename_mat)

%% iteration
xita = solve_inv(M,D,ka,Nx,Ny,N_tot,eps,dx,flag_pde_format);

%% plot
plot_main(xita,dx,Lx,Ly,dt,Nt,path,filename)
