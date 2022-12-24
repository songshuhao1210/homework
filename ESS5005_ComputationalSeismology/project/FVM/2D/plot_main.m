function [im] = plot_main(xx,yy,Q,flag_plot)
    imagesc(xx,yy,Q);
    colorbar;
    set(gca,'CLim',[0,1])
    set(gca,'xaxislocation','top')
    axis ij
    %title(['2D Acoustic pressure field,  t = ' num2str(tt(nt)),'s' ])
    xlabel('x /m')
    ylabel('y /m')
    f=getframe(gcf);
    %imind=frame2im(f);
    im = frame2im(f);
end