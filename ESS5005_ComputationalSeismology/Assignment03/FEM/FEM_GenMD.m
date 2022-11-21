%% Generate M and D
%
% Code by SONG Shuhao
%

%% parameter settings
Nx = 5;    % number of points per row
Ny = 5;    % number of points per column
dx = 0.1;    % length per node

flag_grid = 4; % 3--tri; 4--square
flag_plot_grid = 0; % 1--plot; 0--no plot

%% output setting
path = 'M_D/';
if flag_grid == 3
    filename =  ['tri_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
else
    filename =  ['sqr_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
end

if exist(path) == 0
    mkdir(path)
end

%% create mass and stiff matrix M and D
if flag_grid == 3
    M_D = tri_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);
    M = M_D{1};
    D = M_D{2};
else
    M_D = sqr_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);
    M = M_D{1};
    D = M_D{2};
end

save([path,filename],"D","M");