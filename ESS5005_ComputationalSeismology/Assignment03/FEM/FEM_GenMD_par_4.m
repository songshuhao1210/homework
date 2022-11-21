%% Generate M and D (parallel version)
%
% Code by SONG Shuhao
%

%% parameter settings
NxS = [5,10,15,20,25,30,35,40,45,50];    % number of points per row
NyS = NxS;    % number of points per column
dx = 0.1;    % length per node

flag_grid = 3; % 3--tri; 4--square
flag_plot_grid = 0; % 1--plot; 0--no plot

%% output setting
path = 'M_D/';

if exist(path) == 0
    mkdir(path)
end

%% create mass and stiff matrix M and D
CoreNum = 10;
if isempty(gcp('nocreate'))
    p = parpool(CoreNum);
end

M_D = cell(length(NxS),1);

parfor flag_iter = 1:length(NxS)
    Nx = NxS(flag_iter);
    Ny = NyS(flag_iter);
    N_tot = Nx*Ny
    if flag_grid == 3
        M_D{flag_iter} = tri_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);
    else
        M_D{flag_iter} = sqr_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path);
    end
end
delete(p)

%% save
for i = 1:length(NxS)
    Nx = NxS(i);
    M = M_D{i}{1};
    D = M_D{i}{2};
    if flag_grid == 3
        filename =  ['tri_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
    else
        filename =  ['sqr_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
    end
    save([path,filename],"D","M");
end
