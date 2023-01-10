% 1D elastic wave
clear all

%% flag
flag_plot = 1; % 1--imagesc; 2--3D plot
flag_form = 2; % 1--upwind; 2--Lax
flag_v = 2; %1--homo; 2--hetero

%% parameter settings
x_max = 3000;
y_max = 3000;

%x_max = 1000;
%y_max = 1000;

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
    c1 = 25;
    c2 = 40;
    c(yy<yc,:) = c1;
    c(yy>=yc,:) = c2;
end

eps = 0.1;
ppw = 20;
dt = eps*dx/c1;
Nt = ceil(200/eps);
f = max(max(c))/dx/ppw;

%% config
path = 'Figures/';
%path = 'test/';

if exist(path) == 0
    mkdir(path)
end

if flag_form == 1
    filename = 'EW_2D_upwind';
else
    filename = 'EW_2D_Lax';
end

if flag_v == 1
    filename = [filename,'_homo_eps_',num2str(eps),'_ppw_',num2str(ppw)];
else
    filename = [filename,'_hetero_eps_',num2str(eps),'_ppw_',num2str(ppw)];
end

%% iteration
speed = int32(5/eps);
len_inter = 1;
len_wid = 10;
lx = 3*len_wid+4*len_inter;
ly = 2*len_inter + len_wid;
%speed = 1;
[im,im_s,a] = iteration(xx,yy,Nt,dx,dt,c,rho,f,flag_form,flag_v,yc,speed,len_inter,len_wid);

if exist([path,'source_ppw_',num2str(ppw),'.png']) == 0
    figure(3)
    set(gcf,'Units','centimeter','Position',[20 5 15 8]);
    tt = 1:Nt;
    plot(tt,a)
    xlabel('time (s)')
    ylabel('Amplitude')
    title([ 'f=',num2str(f),' Hz   PPW = ',num2str(ppw)])
    set(gca,'YLim',[-0.6,0.6]);
    set(gca,'XLim',[tt(1) tt(end)]);
    saveas(gcf,[path,'source_ppw_',num2str(ppw),'.png'])
end


for idx = 1:length(im)
    [A,map1] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map1,[path,filename,'.gif'],'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map1,[path,filename,'.gif'],'gif','WriteMode','append','DelayTime',0.1);
    end
end

for idx = 1:length(im_s)
    [B,map2] = rgb2ind(im_s{idx},256);
    if idx == 1
        imwrite(B,map2,[path,filename,'_single.gif'],'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(B,map2,[path,filename,'_single.gif'],'gif','WriteMode','append','DelayTime',0.1);
    end
end

figure(4)
set(gcf,'Units','centimeter','Position',[20 5 lx 4.4*ly]);
a = im{round(1/6*length(im))};
b = im{round(2/6*length(im))};
c = im{round(4/6*length(im))};
d = im{round(5/6*length(im))};
M = [a;b;c;d];
imshow(M)
saveas(gcf,[path,'png_',filename,'.png'])

figure(5)
set(gcf,'Units','centimeter','Position',[20 5 24 25]);
a = im_s{round(1/6*length(im))};
b = im_s{round(2/6*length(im))};
c = im_s{round(4/6*length(im))};
d = im_s{round(6/6*length(im))};
M = [a,b;c,d];
imshow(M)
saveas(gcf,[path,'png_',filename,'_single.png'])

close all
