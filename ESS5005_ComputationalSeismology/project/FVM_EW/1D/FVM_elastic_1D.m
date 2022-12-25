%% 1D elastic wave
close all
%% config
path = 'test/';
if exist(path) == 0
    mkdir(path)
end

flag_form = 2; % 1--Upwind; 2--Lax
flag_v = 1; %1--homo; 2--hetero

%% parameter settings
rho = 2500;

x_max = 10000;
dx = 10;
xx = 0:dx:x_max;
nx = length(xx);


c = zeros(size(xx));
xc = x_max*3/4;
if flag_v == 1
    c1 = 2500;
    c(:,:) = c1;
else
    c1 = 2500;
    c2 = 4000;

    c(xx<xc) = c1;
    c(xx>=xc) = c2;
end

eps = 1;
dt = eps*dx/max(c);
Nt = int32(700/eps);

%% iteration
speed = int32(10/eps);
im = iteration(xx,Nt,dx,dt,c,rho,flag_form,flag_v,xc,speed);

filename = 'test.gif';
for idx = 1:length(im)
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,[path,filename],'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,[path,filename],'gif','WriteMode','append','DelayTime',0.1);
    end
end
close all
