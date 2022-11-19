function [] = plot_main(xita,dx,Lx,Ly,dt,Nt,path,filename)
    %% plot gif
    x = 0:dx:Lx;
    y = 0:dx:Ly;

    for i=1:Nt
        contour(y',x',xita(:,:,i),'Fill','on','LevelStep',5,'LineStyle','-','ShowText','on','LineColor','k');
        xlabel('y[m]');
        ylabel('x[m]');
        axis ij  
        title(['Temperature θ[℃]    t=',num2str(ceil(i*dt)),'s '])
        colorbar
        drawnow

        
        % GIF
        f=getframe(gcf);
        imind=frame2im(f);
        im{i} = frame2im(f);
        [imind,cm]=rgb2ind(imind,256);

        if i==1
             imwrite(imind,cm,[path,filename,'.gif'],'gif', 'Loopcount',inf,'DelayTime',0.5);
        else
             imwrite(imind,cm,[path,filename,'.gif'],'gif','WriteMode','append','DelayTime',0.1);
        end
    end

    %% plot subfig
    N_plot = length(im);
    a = im{round(N_plot/5)};
    b = im{round(N_plot*2/5)};
    c = im{round(N_plot*3/5)};
    d = im{round(N_plot*4/5)};
    M=[a,b;c,d];
    imshow(M)
    %set(gcf)
    %set(gcf,'unit','centimeters','position',[1,2,4*10,15])
    saveas(gcf,[path,filename,'.png'])

end