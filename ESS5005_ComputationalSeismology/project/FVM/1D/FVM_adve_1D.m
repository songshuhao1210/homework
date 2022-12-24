%% 1D scalar advection

%% parameter settings

% physical
x_max = 7500;
dx = 10;
xx = 0:dx:x_max;
yy = 0:dx:y_max;

c1 = 250;
c = zeros(size(xx));
c(:,:) = c1;

eps = 1;
dt = eps*dx/c1;
Nt = 1000;

% path
path = 'test/';

if exist(path) == 0
    mkdir(path)
end


%% iteration
im = iteration(xx,Nt,dx,dt,c,flag_form,flag_plot);
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