%% Heat diffussion by FEM
%
% Code by SONG Shuhao
%

%% parameter settings

ka = 0.012;    % kappa

dx = 1;    % length per node
eps = 0.5;  % e = kappa * dt / dx^2
dt = eps*dx^2 / ka; % time step

Nx = 30;    % number of points per row
Ny = 30;    % number of points per column
Nt = 150;
N_tot = Nx*Ny;

Lx = (Nx-1)*dx;   % length of x
Ly = (Ny-1)*dx;   % length of y


%% initialize temperature field
xita_0 = 100;
xita_old = ones(N_tot,1);
xita_old = xita_0*xita_old;
%xita_old = linspace(1,N_tot,N_tot);

xita_old = bound(xita_old,Nx,Ny);

%% create mass and stiff matrix M and D
[M,D] = tri_Mass_Stiff(N_tot,Nx,dx);

A = M./dt + ka.*D;

%% create source term R
R = R_vec(Nx,Ny,N_tot,dx,ka,xita_old);

%% iteration

% gif setting
xita=zeros(Nx,Ny,Nt);
xita(:,:,1) = reshape(xita_old,Ny,Nx)'; 
flag_gif = 1;

for i=1:Nt
    b = M*xita_old./dt +  R;
    xita_new = A\b;
    xita_new = bound(xita_new,Nx,Ny);
    xita_old = xita_new;
    
    % save for fig
    xita_mat  = reshape(xita_new,Ny,Nx)';
    xita(:,:,flag_gif)=xita_mat;
    flag_gif = flag_gif+1;

end

%% plot
    x = 0:dx:Lx;
    y = 0:dx:Ly;

%plot gif with 2D contour
    fig=figure;
    speeda=1;%两张图播放的间隔时间倍速
    speedb=1;%跳过图片的倍速
    speed=speeda*speedb;%real multiple speed
    for i=1:speedb:Nt
        contour(y',x',xita(:,:,i),'Fill','on','LevelStep',5,'LineStyle','-','ShowText','on','LineColor','k');
        xlabel('y[m]');
        ylabel('x[m]');
        axis ij  
        title(['θ[℃]    t=',num2str(i*dt),'s '])
        colorbar
        drawnow
        frame=getframe(fig);
        im=frame2im(frame);
        [imind,cm]=rgb2ind(im,256);
        if i==1
            imwrite(imind,cm,'heatdiff.gif','gif','LoopCount',inf,'DelayTime',1);
        else 
            if i==Nt
                imwrite(imind,cm,'heatdiff.gif','gif','WriteMode','append','DelayTime',1);
            else
                imwrite(imind,cm,'heatdiff.gif','gif','WriteMode','append','DelayTime',0.1);
            end
        end
    end
    close(fig);
