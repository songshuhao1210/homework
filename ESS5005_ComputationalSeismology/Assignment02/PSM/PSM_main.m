%%% 2D Tsunami modelling
%
% code by Shuhao SONG

close all; clc; clear;

%% parameter settings

% changeable parameters
eps = 0.5;          % time-space relationship control number
ppw = 5;            % numbers of points per wavelength
flag_plot_st = 1;   % 1--save source time function

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
H = loadHeight(nx,ny,ixs,iys);
H = -H;
H(H<0) = 0;
g = 9.85;
c = sqrt(g.*H).*0.001; % km/s

% derived parameters
dt = eps*dx/max(max(c));
f = 2*pi/ppw/dx;

% path
fig_path = 'fig/';
if exist(fig_path) == 0
    mkdir(fig_path)
end

%% plot the source time function
path = fig_path;
if flag_plot_st == 1
    t_s = 0:0.01:2/f;
    plot(t_s,source(f,t_s));
    xlabel('Time /s')
    ylabel('Amplitude /km');
    title('source time funtion of Ricker wavelet')
    fileformat = [path,'/source_time.png'];
    saveas(gcf,fileformat)
end

%% PSM

% setting k based on Nyquist wavenumber
k_max = pi/dx;
dk_x = k_max/(nx/2);
dk_y = k_max/(ny/2);

k_x = 1:nx;
k_x(1:nx/2) = dk_x.*k_x(1:nx/2);
k_x(nx/2+1:end) = k_x(1:nx/2) - k_max;
k_x = -k_x.^2;

k_y = 1:ny;
k_y(1:ny/2) = dk_y.*k_y(1:ny/2);
k_y(ny/2+1:end) = k_y(1:ny/2) - k_max;
k_y = -k_y.^2;

% PSM iteration
tic;

    % gif setting
dt2=50;
gif_2dPSM=zeros(ny,nx,nt/dt2);
flag_gif = 1;

p = zeros(ny,nx);
d2p_x = p;
d2p_y = p;
p_new = p;
p_old = p;

for i = 1:nt
    % spatial contribution
    for j = 1:ny
        F_x = fft(p(j,:));
        F_x = k_x.*F_x;
        d2p_x(j,:) = real(ifft(F_x));
    end
    for j = 1:nx
        F_y = fft(p(:,j));
        F_y = k_y'.*F_y;
        d2p_y(:,j) = real(ifft(F_y));
    end
    p_new=2*p-p_old+c.^2.*dt^2.*(d2p_x+d2p_y);

    % source contribution
    p_new(ny-iys,ixs)=p_new(ny-iys,ixs) + source(f,i*dt)*dt^2;

    % renew
    p_old = p;
    p = p_new;

    % save single
    if mod(i,dt2) == 0 
        gif_2dPSM(:,:,flag_gif)=p;
        flag_gif = flag_gif+1;
    end
   
end
toc;

%% plot 
figure(3)
filename='2D PSM.gif';
%draw 
for pa=1:nt/dt2
 
    imagesc(gif_2dPSM(:,:,pa));
    colorbar('horiz');
    colormap('bone');
    axis equal;
    axis tight;%使坐标轴的最大值最小值与数值一致
    shading interp;
    colormap(winter);
    axis equal
    axis([0,1000,0,800])
    set(gca,'Ydir','reverse');
    xlabel('x');ylabel('y');
    title(['Wave2D PSM  ',num2str(pa*dt2*dt,'%d'),'s'])
    % GIF
    f=getframe(gcf);
    imind=frame2im(f);
    [imind,cm]=rgb2ind(imind,256);
    colormap(winter);
    if pa==1
         imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1e-1);
    else
         imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1e-1);
    end
end