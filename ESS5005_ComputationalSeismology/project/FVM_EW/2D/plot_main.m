function [im] = plot_main(xx,yy,Q,flag_v,yc)
    set(gcf,'position',[250 300 2000 500])
    % sigma_xz
    subplot(1,3,1)
    imagesc(xx,yy,Q(:,:,1));
    if flag_v ~=1
        hold on
        line([xx(1),xx(end)],[yc,yc],'color','red','linestyle','--')
        hold off
    end
    colorbar;
    %set(gca,'CLim',[0,1])
    set(gca,'xaxislocation','top')
    axis ij

    title('stress xz')
    xlabel('x /m')
    ylabel('y /m')
    set(gca,'YLim',[yy(1) yy(end)]);
    set(gca,'XLim',[xx(1) xx(end)]);
    
    % sigma_yz
    subplot(1,3,2)
    imagesc(xx,yy,Q(:,:,2));
    if flag_v ~=1
        hold on
        line([xx(1),xx(end)],[yc,yc],'color','red','linestyle','--')
        hold off
    end
    colorbar;
    %set(gca,'CLim',[0,1])
    set(gca,'xaxislocation','top')
    axis ij

    title('stress yz')
    xlabel('x /m')
    ylabel('y /m')
    set(gca,'YLim',[yy(1) yy(end)]);
    set(gca,'XLim',[xx(1) xx(end)]);
    
    % velocity
    subplot(1,3,3)
    imagesc(xx,yy,Q(:,:,3));
    if flag_v ~=1
        hold on
        line([xx(1),xx(end)],[yc,yc],'color','red','linestyle','--')
        hold off
    end
    colorbar;
    %set(gca,'CLim',[-1e-7,1e-7])
    set(gca,'xaxislocation','top')
    axis ij

    title('velocity')
    xlabel('x /m')
    ylabel('y /m')
    set(gca,'YLim',[yy(1) yy(end)]);
    set(gca,'XLim',[xx(1) xx(end)]);

    f=getframe(gcf);
    im = frame2im(f);
end