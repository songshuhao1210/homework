%% Heat diffussion by FEM
%
% Code by SONG Shuhao
%

%% parameter settings

Lx = 100;   % length of x
Ly = 100;   % length of y
ka = 10;    % kappa

dx = 10;    % length per node
eps = 0.5;  % e = kappa * dt / dx^2
dt = eps*dx^2 / ka; % time step

Nx = 10;    % number of points per row
Ny = 10;    % number of points per column
N_tot = Nx*Ny;

%% initialize temperature field
xita_0 = 60;
xita_old = ones(N_tot,1);
xita_old = xita_0*xita_old;

xita_old = linspace(1,N_tot,N_tot);

xita_old = bound(xita_old,Nx,Ny);
xita_new = xita_old;
%% create mass and stiff matrix