function [im] = plot_main(xx,yy,Q,t)
    imagesc(xx,yy,Q);
    colorbar;
    set(gca,'CLim',[0,1])
    set(gca,'xaxislocation','top')
    axis ij
    title(['t = ' num2str(t),' s' ])
    xlabel('x /m')
    ylabel('y /m')
    f=getframe(gcf);
    %imind=frame2im(f);
    im = frame2im(f);
end