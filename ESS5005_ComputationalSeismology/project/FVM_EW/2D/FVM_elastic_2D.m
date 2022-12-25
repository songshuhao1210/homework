%% 1D elastic wave
close all
%% config
path = 'test/';

if exist(path) == 0
    mkdir(path)
end

flag_plot = 1; % 1--imagesc; 2--3D plot
flag_form = 2; % 1--upwind; 2--Lax
flag_v = 1; %1--homo; 2--hetero

%% parameter settings
x_max = 3000;
y_max = 3000;
dx = 10;
xx = 0:dx:x_max;
yy = 0:dx:y_max;

rho = 2500;
c = zeros(length(yy),length(xx));
yc = x_max*3/4;
if flag_v == 1
    c1 = 25;
    c(:,:) = c1;
else
    c1 = 2500;
    c2 = 4000;
    c(yy<yc,:) = c1;
    c(yy>=yc,:) = c2;
end

eps = 0.1;
ppw = 10;
dt = eps*dx/c1;
Nt = int32(100/eps);
f = max(max(c))/dx/ppw;
%% iteration
speed = int32(10/eps);
%speed = 1;
[im,a] = iteration(xx,yy,Nt,dx,dt,c,rho,f,flag_form,flag_v,yc,speed);

tt = 1:Nt;
plot(tt,a)



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

