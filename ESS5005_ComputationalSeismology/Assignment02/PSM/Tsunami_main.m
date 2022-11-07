%%% 2D Tsunami modelling
%
% code by Shuhao SONG

close all; clc; clear;

%% parameter settings

% changeable parameters
eps = 0.5;          % time-space relationship control number
ppw = 100;            % numbers of points per wavelength

flag_source_location = 1;   % 1--Sumendala earthquake in 2004; 2--center
flag_source_type = 2;       % 1--Richer; 2--Gaussian
flag_plot_st = 0;   % 1--save source time function


% path
fig_path = 'fig_tsunami/';
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

if flag_source_location == 1
    slat = 3.3;
    slon = 95.87;
    
    latref = -40;
    lonref = 35;
    
    [ixs,iys] = xcoord_convert(slat,slon,latref,lonref,dx);
else
    ixs = nx/2;
    iys = ny/2;
end

    % velocity model
flag_fig_num = 1;
if flag_source_location == 1
    [H,flag_fig_num] = loadHeight(nx,ny,ixs,iys,flag_fig_num,fig_path,flag_plot_st);
    H = -H;
    H(H<0) = 0;
else
    H = ones(ny,nx);
    H = H.*8870;
end
g = 9.85;
c = sqrt(g.*H).*0.001; % km/s

% derived parameters
dt = eps*dx/max(max(c));
f = 2*pi/ppw/dx;

flag_ratio = ppw/1000;



%% plot the source time function
path = fig_path;
dt2 = 50;
if flag_plot_st == 1
    figure(flag_fig_num)

    subplot(2,1,1)

    Fs = 0.02/flag_ratio;            % 采样频率
    T = 1/Fs;             % 采样周期
    L = 400/flag_ratio;    % 信号长度
    t = (0:L-1)*T;        % 时间相量
    s0 = source_time(f,t,flag_source_type);

    plot(t(1:L/4),s0(1:L/4));
    xlabel('Time /s')
    ylabel('Amplitude /km');
    
    if flag_source_type == 1
        subtitle(['Source Time Funtion of Richer Wavelet ( dominal frequncy f = ',num2str(f,'%.2d'),' Hz )'])
    else
        subtitle(['Source Time Funtion of Gaussian Wavelet ( dominal frequncy f = ',num2str(f,'%.2d'),' Hz )'])
    end
    
    subplot(2,1,2)

    Y = fft(s0);
    P2 = abs(Y/L);  % 每个量除以数列长度 L
    P1 = P2(1:L/2+1);  % 取交流部分
    P1(2:end-1) = 2*P1(2:end-1); % 交流部分模值乘以2
    ff = Fs*(0:(L/2))/L;
    plot(ff(1:L/4),P1(1:L/4))
    subtitle('Amplitude Spectrum of Source Time Function')
    xlabel('f /Hz')
    ylabel('|Norm|')
    flag_fig_num = flag_fig_num + 1;

    fileformat = [path,'/source.png'];
    saveas(gcf,fileformat)
end

%% PSM
filename = 'PSM';
title = 'PSM';
path = [fig_path,'PSM/'];

if exist(path) ~= 0
    rmdir(path,'s')
end
mkdir(path)

flag_fig_num = PSM(flag_ratio,nx,ny,nt,dx,dt,c,H,f,ixs,iys,flag_source_type,title,dt2,flag_fig_num,filename,path);

%% FDM_2nd
flag_FDM = 2;

filename = 'FDM_2nd';
title = 'FDM 2nd';
path = [fig_path,'FDM_2nd/'];

if exist(path) ~= 0
    rmdir(path,'s')
end
mkdir(path)

flag_fig_num = FDM(flag_FDM,flag_ratio,nx,ny,nt,dx,dt,c,H,f,ixs,iys,flag_source_type,title,dt2,flag_fig_num,filename,path);

%% FDM_4nd
flag_FDM = 4;

filename = 'FDM_4nd';
title = 'FDM 4nd';
path = [fig_path,'FDM_4nd/'];

if exist(path) ~= 0
    rmdir(path,'s')
end
mkdir(path)

flag_fig_num = FDM(flag_FDM,flag_ratio,nx,ny,nt,dx,dt,c,H,f,ixs,iys,flag_source_type,title,dt2,flag_fig_num,filename,path);




