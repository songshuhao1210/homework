%% 1D elastic wave
close all
clear all

%% parameter settings
flag_form = 2; % 1--Upwind; 2--Lax
flag_v = 2; %1--homo; 2--hetero
eps = 0.5;

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

dt = eps*dx/max(c);
Nt = ceil(700/eps);

%% config
path = 'Figures/';
%path = 'test/';
if exist(path) == 0
    mkdir(path)
end



if flag_form == 1
    filename = 'EW_1D_upwind';
else
    filename = 'EW_1D_Lax';
end

if flag_v == 1
    filename = [filename,'_homo_eps_',num2str(eps)];
else
    filename = [filename,'_hetero_eps_',num2str(eps)];
end

%% iteration
speed = int32(10/eps);
im = iteration(xx,Nt,dx,dt,c,rho,flag_form,flag_v,xc,speed);

for idx = 1:length(im)
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,[path,filename,'.gif'],'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,[path,filename,'.gif'],'gif','WriteMode','append','DelayTime',0.1);
    end
end

figure(2)
set(gcf,'Units','centimeter','Position',[20 5 24 25]);
a = im{round(1/6*length(im))};
b = im{round(2/6*length(im))};
c = im{round(4/6*length(im))};
d = im{round(5/6*length(im))};
M = [a;b;c;d];
imshow(M)
saveas(gcf,[path,'png_',filename,'.png'])

