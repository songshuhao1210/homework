clear clc
%Code by Song Shuhao

%This program aims to imitate the process of heat diffusion

%baisc information
    Lx=30;      %The length of a horizontal line
    Ly=10;      %The length of a vertical line
    del=0.1;    %The interval between two adjacent points that recorded
    k0=0.012;   %The heat diffusion rate

%Definitions for ICs
    citaABCD=[100;25;50;75];    %The temperature of A,B,C,D in real system
    citacenter=100;             %The initial temperature inside the square

%Normalozation 
    td=0.1;             %The time of dimensionless system
    times=Lx*Ly/k0;%The multiple of time in contrast to dimensionless
    delxd=1/Lx*del;     %The interval between two horizontally adjacent points
    delyd=1/Ly*del;     %The interval between two vertically adjacent poits
    Nx=int32(1/delxd+1);%The number of poits of a horizontal line
    Ny=int32(1/delyd+1);%The number of poits of a vertical line
    Nt=int32(times*td+1);             %The number of time to be recorded
    deltd=td/double(Nt-1);    %The time interval between two record times


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
        lambdax=deltd/delxd^2;
        lambday=deltd/delyd^2;
        A=(1-lambdax-lambday)/(1+lambdax+lambday);
        B=lambdax/(1+lambdax+lambday);
        C=lambday/(1+lambdax+lambday);
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
        citad(:,:,t)=U;
    end

%revise to real system
    cita=citad*(max(citaABCD)-min(citaABCD))+min(citaABCD);%The real heat function
    x=Lx*xd;%The real horizontal coordinates of record points
    y=Ly*yd;%The real vertical coordinates of record points

%plot gif with 2D contour
    fig=figure;
    speeda=10;%两张图播放的间隔时间倍速
    speedb=10;%跳过图片的倍速
    speed=speeda*speedb;%real multiple speed
    for i=1:speedb:Nt
        contour(y',x',cita(:,:,i),'Fill','on','LevelStep',5,'LineStyle','-','ShowText','on','LineColor','k');
        xlabel('y[m]');
        ylabel('x[m]');
        title(['θ[℃]    t=',num2str(round(times*td*(i-1)/(Nt-1))),'s   speed:X',num2str(ceil(speed))])
        colorbar
        drawnow
        frame=getframe(fig);
        im=frame2im(frame);
        [imind,cm]=rgb2ind(im,256);
        if i==1
            imwrite(imind,cm,'heatdiffLtoR.gif','gif','LoopCount',inf,'DelayTime',1);
        else 
            if i==Nt
                imwrite(imind,cm,'heatdiffLtoR.gif','gif','WriteMode','append','DelayTime',1);
            else
                imwrite(imind,cm,'heatdiffLtoR.gif','gif','WriteMode','append','DelayTime',1/speeda);
            end
        end
    end
    close(fig);