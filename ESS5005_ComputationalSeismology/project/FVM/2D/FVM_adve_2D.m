%% 2D scalar advection
close all
%% parameter settings

% physical
x_max = 50;
y_max = 50;
dx = 1;
xx = 0:dx:x_max;
yy = 0:dx:y_max;

c1 = 20;
c = zeros(length(yy),length(xx));
c(:,:) = c1;

eps = 0.5;
dt = eps*dx/c1;
Nt = int32(50/eps);

% path
path = 'test/';

if exist(path) == 0
    mkdir(path)
end

% flag settings
flag_plot = 1; % 1--imagesc; 2--3D plot
flag_form = 2; % 1--upwind; 2--Lax

%% iteration
im = iteration(xx,yy,Nt,dx,dt,c,flag_form,flag_plot);
speed = 30;
filename = 'test.gif';
for idx = 1:speed:length(im)
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,[path,filename],'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,[path,filename],'gif','WriteMode','append','DelayTime',0.01);
    end
end
close all