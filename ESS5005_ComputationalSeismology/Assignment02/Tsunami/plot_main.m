function [flag_fig_num] = plot_main(flag_c,nx,ny,nt,dt,H,gif_2dPSM,dt2,flag_fig_num,title_x,path,filename)
    %% plot gif
    figure(flag_fig_num)
    x = 1 : nx;
    y = 1 : ny;
    [ X, Y ] = meshgrid( x, y );%二维网格坐标
    for pa=1:nt/dt2
        pcolor(gif_2dPSM(:,:,pa));
        axis equal;axis equal;
        colorbar('horiz');
        shading interp;
        %axis tight;%使坐标轴的最大值最小值与数值一致
        %shading interp;
        
%         if flag_c == 1
%             caxis([-0.06 0.06]);
%         else
%             caxis([-0.03 0.03]);
%         end
        
        mycolorMap = jet;
        %mycolorMap(33,:) = [1 1 1];
        colormap(mycolorMap);
        caxis([-0.01 0.01])


    
        axis([0,nx,0,ny])
        set(gca,'Ydir','reverse');
        xlabel('x');ylabel('y');
        title([ [title_x,'   '] ,num2str(pa*dt2*dt,'%4d'),'s'])
        
%         if max(max(H)) ~= min(min(H))
%             hold on
%             contour(X,Y,H)
%             hold off
%         end
        
        % GIF
        f=getframe(gcf);
        imind=frame2im(f);
        im{pa} = frame2im(f);
        [imind,cm]=rgb2ind(imind,256);
        colormap(jet); 
        if pa==1
             imwrite(imind,cm,[path,filename,'.gif'],'gif', 'Loopcount',inf,'DelayTime',0.5);
        else
             imwrite(imind,cm,[path,filename,'.gif'],'gif','WriteMode','append','DelayTime',0.5e-1);
        end
    end
    flag_fig_num = flag_fig_num + 1;

    %% plot subfig
    figure(flag_fig_num)
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

    flag_fig_num = flag_fig_num + 1;


end