%% Heat diffussion by FEM
%
% Code by SONG Shuhao
%

%% parameter settings

ka = 0.012;    % kappa
Nx = 20;    % number of points per row
Ny = 20;    % number of points per column
dx = 1;    % length per node
eps = 1;  % e = kappa * dt / dx^2

flag_grid = 3; % 3--tri; 4--square
flag_plot_grid = 1; % 1--plot; 0--no plot

Nt = 20/eps;
dt = eps*dx^2 / ka; % time step
N_tot = Nx*Ny;
Lx = (Nx-1)*dx;   % length of x
Ly = (Ny-1)*dx;   % length of y

%% output
path = 'output_tri/';
filename =  'heatdiff_tri';
if exist(path) == 0
    mkdir(path)
end

%% initialize temperature field
xita_0 = 100;
xita_old = ones(N_tot,1);
xita_old = xita_0*xita_old;
%xita_old = linspace(1,N_tot,N_tot);

xita_old = bound(xita_old,Nx,Ny);

%% create mass and stiff matrix M and D
[M,D] = tri_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);

A = M./dt + ka.*D;

%% create source term R
R = R_vec(Nx,Ny,N_tot,dx,ka,xita_old);

%% iteration

% gif setting
xita=zeros(Nx,Ny,Nt);
xita(:,:,1) = reshape(xita_old,Ny,Nx)'; 
flag_gif = 1;

for i=1:Nt
    b = M*xita_old./dt +  R;
    xita_new = A\b;
    xita_new = bound(xita_new,Nx,Ny);
    xita_old = xita_new;
    
    % save for fig
    xita_mat  = reshape(xita_new,Ny,Nx)';
    xita(:,:,flag_gif)=xita_mat;
    flag_gif = flag_gif+1;

end

%% plot
plot_main(xita,dx,Lx,Ly,dt,Nt,path,filename)
