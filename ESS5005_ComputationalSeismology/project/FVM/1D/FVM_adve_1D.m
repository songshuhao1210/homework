%% 1D scalar advection
clear all
%% parameter settings

% physical
x_max = 3000;
dx = 10;
xx = 0:dx:x_max;

c1 = 2500;
c = zeros(size(xx));
c(:,:) = c1;

eps = 0.5;
dt = eps*dx/c1;
Nt = ceil(2500/eps);

% path
path = 'Figures/';
filename = ['Advection_1D_eps_',num2str(eps)];
if exist(path) == 0
    mkdir(path)
end

flag_bound = 2; % 1--absorb; 2--period

%% initialization
xc = 1000;
Q_up = init_Q(xx,xc);
Q_Lax = Q_up;
Q_theory = Q_up;
im{1} = plot_main(xx,Q_up,Q_Lax,Q_theory,0);

%% Lax 
speed = 10;
flag_im = 2;
for ti = 2:Nt
    Q_old_up = Q_up;
    Q_old_Lax = Q_Lax;
    dQ_up = zeros(size(Q_old_up));
    dQ_Lax_1 = dQ_up;
    dQ_Lax_2 = dQ_up;
    for i = 2:length(xx)-1
        dQ_up(i) = Q_old_up(i)-Q_old_up(i-1); 
        dQ_Lax_1(i) = Q_old_Lax(i+1) - 2*Q_old_Lax(i) + Q_old_Lax(i-1);
        dQ_Lax_2(i) = Q_old_Lax(i+1) - Q_old_Lax(i-1);
    end
    Q_up = Q_old_up - dt/dx*dQ_up.*c;
    Q_Lax = Q_old_Lax - dt/dx/2.*dQ_Lax_2.*c + 0.5*(dt/dx)^2.*dQ_Lax_1.*c.^2;
    xc = xc + c*dt;
    Q_theory = init_Q(xx,mod(xc,xx(end)));
    Q_up = boundary_Q(Q_up,xx,flag_bound);
    Q_Lax = boundary_Q(Q_Lax,xx,flag_bound);
    if mod(ti,speed) == 0
        im{flag_im} = plot_main(xx,Q_up,Q_Lax,Q_theory,(ti-1)*dt);
        flag_im = flag_im + 1;
    end
    % absorbing
    %Q_up(1,nx-1,ti) = Q_up(1,nx-2,ti);
    %Q_Lax(1,nx-1,ti) = Q_Lax(1,nx-2,ti);
    % periodic
    % Q_up(1,1,ti) = Q_up(1,nx-2,ti);
    % Q_Lax(1,1,ti) = Q_Lax(1,nx-2,ti);
end

%% plot

for idx = 1:length(im)
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
e = im{round(5/6*length(im))};
f = im{round(6/6*length(im))};
M = [a,b;c,d;e,f];
imshow(M)
saveas(gcf,[path,'png_',filename,'.png'])

close all