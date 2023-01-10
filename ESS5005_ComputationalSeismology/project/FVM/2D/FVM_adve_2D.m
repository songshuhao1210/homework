%% 2D scalar advection
close all
%% parameter settings

% physical
x_max = 100;
y_max = 100;
dx = 1;
xx = 0:dx:x_max;
yy = 0:dx:y_max;

c1 = 20;
c = zeros(length(yy),length(xx));
c(:,:) = c1;

eps = 0.5;
dt = eps*dx/c1;
Nt = ceil(100/eps);

% flag settings
flag_form = 2; % 1--upwind; 2--Lax

% path
path = 'Figures/';
if flag_form == 1
    filename = ['Advection_2D_upwind_eps_',num2str(eps)];
else
    filename = ['Advection_2D_Lax_eps_',num2str(eps)];
end

if exist(path) == 0
    mkdir(path)
end



%% iteration
speed = ceil(0.5/eps);
im = iteration(xx,yy,Nt,dx,dt,c,speed,flag_form);


for idx = 1:speed:length(im)
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,[path,filename,'.gif'],'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,[path,filename,'.gif'],'gif','WriteMode','append','DelayTime',0.1);
    end
end

figure(2)
set(gcf,'Units','centimeter','Position',[20 5 24 20]);
a = im{round(1/6*length(im))};
b = im{round(2/6*length(im))};
c = im{round(3/6*length(im))};
d = im{round(4/6*length(im))};
M = [a,b;c,d];
imshow(M)
saveas(gcf,[path,'png_',filename,'.png'])

close all

