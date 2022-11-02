%%% 2D Tsunami modelling
%
% code by Shuhao SONG

close all; clc; clear;

%% parameter settings

% changeable parameters
eps = 0.2;          % time-space relationship control number
ppw = 400;            % numbers of points per wavelength

flag_plot_st = 0;   % 1--save source time function
dt2 = 50;

% path
fig_path = 'fig/';
if exist(fig_path) == 0
    mkdir(fig_path)
end


% fixed parameters

    % spatial and time scheme
dx = 10;            % x,y step length
nx = 1000;          % total number of x points
ny = 800;           % total number of y points
nt = 3000;          % total number of t steps

    % source location
slat = 3.3;
slon = 95.87;

latref = -40;
lonref = 35;

[ixs,iys] = xcoord_convert(slat,slon,latref,lonref,dx);

    % velocity model
flag_fig_num = 1;
[H,flag_fig_num] = loadHeight(nx,ny,ixs,iys,flag_fig_num,fig_path,flag_plot_st);
H = -H;
H(H<0) = 0;
g = 9.85;
c = sqrt(g.*H).*0.001; % km/s

% derived parameters
dt = eps*dx/max(max(c));
f = 2*pi/ppw/dx;


%% plot the source time function
path = fig_path;
if flag_plot_st == 1
    figure(flag_fig_num)
    t_s = 0:1:4/f;
    plot(t_s,source(f,t_s));
    xlabel('Time /s')
    ylabel('Amplitude /km');
    axis([0,4/f,-1.5,1.5])
    title('Source time funtion of Ricker wavelet')
    fileformat = [path,'/source_time.png'];
    saveas(gcf,fileformat)
    flag_fig_num = flag_fig_num + 1;
end

%% PSM
filename = 'PSM';
title = 'PSM';
path = [fig_path,'PSM/'];

if exist(path) ~= 0
    rmdir(path,'s')
end
mkdir(path)

flag_fig_num = PSM(nx,ny,nt,dx,dt,c,H,f,ixs,iys,title,dt2,flag_fig_num,filename,path);

%% FDM_2nd
flag_FDM = 2;

filename = 'FDM_2nd';
title = 'FDM 2nd';
path = [fig_path,'FDM_2nd/'];

if exist(path) ~= 0
    rmdir(path,'s')
end
mkdir(path)

flag_fig_num = FDM(flag_FDM,nx,ny,nt,dx,dt,c,H,f,ixs,iys,title,dt2,flag_fig_num,filename,path);

%% FDM_4nd
flag_FDM = 4;

filename = 'FDM_4nd';
title = 'FDM 4nd';
path = [fig_path,'FDM_4nd/'];

if exist(path) ~= 0
    rmdir(path,'s')
end
mkdir(path)

flag_fig_num = FDM(flag_FDM,nx,ny,nt,dx,dt,c,H,f,ixs,iys,title,dt2,flag_fig_num,filename,path);




