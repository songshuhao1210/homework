%% Heat diffussion by FEM parfor
%
% Code by SONG Shuhao
%

%% parameter settings
epsS = 0.4:0.2:3;  % e = kappa * dt / dx^2

ka = 0.012;    % kappa
Nx = 100;    % number of points per row
Ny = 100;    % number of points per column
dx = 1;    % length per node


flag_grid = 3; % 3--tri; 4--square
flag_plot_grid = 0; % 1--plot; 0--no plot

Nt = 10/eps;
N_tot = Nx*Ny;
Lx = (Nx-1)*dx;   % length of x
Ly = (Ny-1)*dx;   % length of y

%% output
path = 'output_eps/';
if exist(path) == 0
    mkdir(path)
end

%% create mass and stiff matrix M and D
[M,D] = tri_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);

%% create source term R
%R = R_vec(Nx,Ny,N_tot,dx,ka,xita_old);
R = sparse(N_tot,1);

%% iteration parfor
CoreNum = 4;
if isempty(gcp('nocreate'))
    p = parpool(CoreNum);
end

par_xita = cell(length(epsS));

parfor flag_iter = 1:length(epsS)
    eps = epsS(flag_iter)
    par_xita{flag_iter} = solve_inv(M,D,R,ka,Nt,Nx,Ny,N_tot,eps,dx);
end

delete(p)

%% plot
for i = 1:length(epsS)
    filename =  ['heatdiff_test_esp_',num2str(epsS(i))];
    plot_main(xita,dx,Lx,Ly,dt,Nt,path,filename)
end