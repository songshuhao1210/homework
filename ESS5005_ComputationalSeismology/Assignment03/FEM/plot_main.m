function [] = plot_main(xita,dx,Lx,Ly,eps,ka,Nx,path,filename,flag_len,speed)
    %% plot gif
    figure(1)
    x = 0:dx:Lx;
    y = 0:dx:Ly;
    [Nt,dt] = N_t(Nx,eps,ka,dx,flag_len);

    for i=1:speed:Nt
        set(gcf,'Units','centimeter','Position',[5 5 14 10]);
        contour(y',x',xita(:,:,i),'Fill','on','LevelStep',5,'LineStyle','-','ShowText','on','LineColor','k');
        xlabel('y[m]');
        ylabel('x[m]');
        axis ij  
        title(['Temperature θ[℃]    t=',num2str(ceil(i*dt)),'s  dt=',num2str(dt),'s'])
        colorbar
        drawnow

        
        % GIF
        f=getframe(gcf);
        imind=frame2im(f);
        im{ceil(i/speed)} = frame2im(f);
        [imind,cm]=rgb2ind(imind,256);
        

        if i==1
             imwrite(imind,cm,[path,filename,'.gif'],'gif', 'Loopcount',inf,'DelayTime',0.5);
        else
             imwrite(imind,cm,[path,filename,'.gif'],'gif','WriteMode','append','DelayTime',0.1);
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
    saveas(gcf,[path,filename,'.png'])

end