clear clc
clear all
%Code by Song Shuhao

%This program aims to imitate the process of heat diffusion

%baisc information
    Lx=49;      %The length of a horizontal line
    Ly=49;      %The length of a vertical line
    dx=1;    %The interval between two adjacent points that recorded
    k0=1.9e-5;   %The heat diffusion rate

    eps = 5;

%Definitions for ICs
    citaABCD=[100;25;50;75];    %The temperature of A,B,C,D in real system
    citacenter=100;             %The initial temperature inside the square

%Normalization 
    td=1;              %The time of dimensionless system
    
    
    dt = eps*dx^2 / k0;

    
    delxd=1/Lx*dx;     %The interval between two horizontally adjacent points
    delyd=1/Ly*dx;     %The interval between two vertically adjacent poits
    Nx=int32(1/delxd+1);%The number of poits of a horizontal line
    Ny=int32(1/delyd+1);%The number of poits of a vertical line
    Nt = floor(0.1/eps*(Nx/10)^2*Nx);
    times=Lx*Ly/k0;                     %The multiple of time in contrast to dimensionless
    deltd=dt/times;    %The time interval between two record times


    citaABCDd=(citaABCD-min(citaABCD))/(max(citaABCD)-min(citaABCD));    
    %The temperature of A,B,C,D in dimensionless system
    citacenterd=(citacenter-min(citaABCD))/(max(citaABCD)-min(citaABCD));
    %The initial temperature inside the square in dinmensionless system

    xd=0:delxd:1; %The dimensionless horizontal coordinates of record points
    yd=0:delyd:1;  %The dimensionless vertical coordinates of record points
    citad=zeros(Nx,Ny,Nt);%The dimensionless heat funtion
    citad(:,:,1)=citacenterd;

%Give IBs
    for i=1:Nx
        citad(i,Ny,:)=(citaABCDd(1,1)-citaABCDd(2,1))*xd(1,i)+citaABCDd(2,1);
        citad(i,1,:)=(citaABCDd(4,1)-citaABCDd(3,1))*xd(1,i)+citaABCDd(3,1);
    end
    for i=1:Ny
       citad(Nx,i,:)=(citaABCDd(1,1)-citaABCDd(4,1))*yd(1,i)+citaABCDd(4,1);
       citad(1,i,:)=(citaABCDd(2,1)-citaABCDd(3,1))*yd(1,i)+citaABCDd(3,1);
    end

%Iteration for different time in dimensionless system
    U=citad(:,:,1);%iteration from left to right
    V=U;           %iteration from right to left
    for t=2:Nt
        lambda=2*deltd/delxd^2;
        A=(1-lambda)/(1+lambda);
        B=lambda/2/(1+lambda);
        C=B;
        for i=2:Nx-1
            for j=2:Ny-1
                U(i,j)=A*U(i,j)+B*(U(i-1,j)+U(i+1,j))+C*(U(i,j-1)+U(i,j+1));
            end
        end
        for i=Nx-1:-1:2
            for j=Ny-1:-1:2
                V(i,j)=A*V(i,j)+B*(V(i-1,j)+V(i+1,j))+C*(V(i,j-1)+V(i,j+1));
            end
        end
        citad(:,:,t)=(U+V)/2;
    end

%revise to real system
    cita=citad*(max(citaABCD)-min(citaABCD))+min(citaABCD);%The real heat function
    x=Lx*xd;%The real horizontal coordinates of record points
    y=Ly*yd;%The real vertical coordinates of record points

%plot gif with 2D contour
    figure(1)
    
    speed = floor(ceil(1/eps));
    flag_this = 1;
    for i=1:speed:Nt
        set(gcf,'Units','centimeter','Position',[5 5 14 10]);
        contour(y',x',cita(:,:,i),'Fill','on','LevelStep',5,'LineStyle','-','ShowText','on','LineColor','k');
        xlabel('y[m]');
        ylabel('x[m]'); 
        title(['Temperature    t=',num2str(ceil(i*dt)),'s  dt=',num2str(dt),'s'])
        colorbar
        drawnow

        
        % GIF
        f=getframe(gcf);
        imind=frame2im(f);
        im{flag_this} = frame2im(f);
        [imind,cm]=rgb2ind(imind,256);
        flag_this = flag_this + 1;

        if i==1
             imwrite(imind,cm,"FDM.gif",'gif', 'Loopcount',inf,'DelayTime',0.5);
        else
             imwrite(imind,cm,'FDM.gif','gif','WriteMode','append','DelayTime',0.1);
        end
    end

    %% plot subfig
    figure(2)
    set(gcf,'Units','centimeter','Position',[5 5 30 20]);
    N_plot = length(im);
    a = im{round(N_plot*2/10)};
    b = im{round(N_plot*4/10)};
    c = im{round(N_plot*7/10)};
    d = im{round(N_plot*10/10)};
    M=[a,b;c,d];
    imshow(M)
    %set(gcf)
    %set(gcf,'unit','centimeters','position',[1,2,4*10,15])
    saveas(gcf,'FDM.png')

    