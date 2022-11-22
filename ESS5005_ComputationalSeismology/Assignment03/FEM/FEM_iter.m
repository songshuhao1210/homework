%% Heat diffussion by FEM
%
% Code by SONG Shuhao
%
close all
clear all

%% parameter settings
epsS = 0.09;  % e = kappa * dt / dx^2
Nx = 30;    % number of points per row
Ny = 30;    % number of points per column
dx = 1;    % length per node

flag_grid = 3; % 3--tri; 4--square
flag_pde_format = 1; % 1--explicit; 2--implicit
flag_len  = 2;% 1--normal;  2--short;
flag_speed = 100;

ka = 0.019;    % kappa  mm^2/s

N_tot = Nx*Ny;
Lx = (Nx-1)*dx;   % length of x
Ly = (Ny-1)*dx;   % length of y
path_mat = 'M_D/';

%% output
path = 'output_test/';

if exist(path) == 0
    mkdir(path)
end

%% import M and D


%% iteration
for i=1:length(epsS)
    eps = epsS(i);
    [filename,filename_mat] = file_name(dx,eps,Nx,flag_grid,flag_pde_format);
    filename_mat = [path_mat,filename_mat];
    load(filename_mat)
    xita = solve_inv(M,D,ka,Nx,Ny,N_tot,eps,dx,flag_pde_format,flag_len);
end

%% plot
plot_main(xita,dx,Lx,Ly,eps,ka,Nx,path,filename,flag_len,flag_speed)
