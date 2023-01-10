function [im,im_s] = plot_main(xx,yy,Q,flag_v,yc,x,d,t)
    
    figure(1)
    c_s = 8e+4;
    c_v = 1.2;
    lx = 3*d+4*x;
    ly = d+4*x;

    set(gcf,'Units','centimeter','Position',[5 20 3*d+4*x d+2*x]);
    % sigma_xz
    pos1 = [ x/lx x/ly d/lx d/ly];
    subplot('Position',pos1)
    imagesc(xx,yy,Q(:,:,1));
    if flag_v == 2
        hold on
        line([xx(1),xx(end)],[yc,yc],'color','red','linestyle','--')
        hold off
    end
    %colorbar;
    %set(gca,'CLim',[-c_s,c_s])
    %set(gca,'xaxislocation','top')
    axis ij

    title('Stress σ_{xz}')
    %xlabel('x /m')
    %ylabel('y /m')
    set(gca,'YLim',[yy(1) yy(end)]);
    set(gca,'XLim',[xx(1) xx(end)]);
    
    % sigma_yz
    pos2 = [ (2*x+d)/lx x/ly d/lx d/ly];
    subplot('Position',pos2)
    imagesc(xx,yy,Q(:,:,2));
    if flag_v == 2
        hold on
        line([xx(1),xx(end)],[yc,yc],'color','red','linestyle','--')
        hold off
    end
    %colorbar;
    %set(gca,'CLim',[-c_s,c_s])
    %set(gca,'xaxislocation','top')
    axis ij

    title('Stress σ_{yz}')
    %xlabel('x /m')
    %ylabel('y /m')
    set(gca,'YLim',[yy(1) yy(end)]);
    set(gca,'XLim',[xx(1) xx(end)]);
    
    % velocity
    pos3 = [ (3*x+2*d)/lx x/ly d/lx d/ly];
    subplot('Position',pos3)
    imagesc(xx,yy,Q(:,:,3));
    if flag_v ~=1
        hold on
        line([xx(1),xx(end)],[yc,yc],'color','red','linestyle','--')
        hold off
    end
    %colorbar;
    %set(gca,'CLim',[-c_v,c_v])
    %set(gca,'xaxislocation','top')
    axis ij

    title('Velocity')
    %xlabel('x /m')
    %ylabel('y /m')
    set(gca,'YLim',[yy(1) yy(end)]);
    set(gca,'XLim',[xx(1) xx(end)]);

    sgtitle(['t = ',num2str(t),'s'])

    f=getframe(gcf);
    im = frame2im(f);

    figure(2)
    set(gcf,'Units','centimeter','Position',[20 5 12 6]);
    Q_s = zeros(length(xx),2);
    for i = 1:length(xx)
        Q_s(i,1) = Q(i,i,3);
        Q_s(i,2) = Q(int32(length(xx)/2),i,3);
    end

    xc = xx(end)/2;
    plot(xx-xc,Q_s(:,1),'red')
    hold on
    plot((xx-xc)./sqrt(2),Q_s(:,2),'blue--')
    ylabel('velocity')
    set(gca,'YLim',[-2,2]);
    set(gca,'XLim',[xx(1)-xc xx(end)-xc]);
    set(gca,'xtick',[])
    title(['t = ',num2str(t),'s'])
    legend('y=x','x = xc')
    
    hold off
    f=getframe(gcf);
    im_s = frame2im(f);


end