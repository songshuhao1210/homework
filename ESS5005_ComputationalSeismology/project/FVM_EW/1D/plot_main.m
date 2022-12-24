function [im] = plot_main(xx,Q,flag_v,xc)
    subplot(2,1,1)
    plot(xx,Q(1,:))
    if flag_v ~=1
        hold on
        line([xc,-1],[xc,1],'color','blue','linestyle','--')
        hold off
    end
    ylabel('stress')
    set(gca,'YLim',[-1,1]);
    set(gca,'XLim',[xx(1) xx(end)]);
    set(gca,'xtick',[])

    subplot(2,1,2)
    plot(xx,Q(2,:))
    if flag_v ~=1
        hold on
        line([xc,-1],[xc,1],'color','blue','linestyle','--')
        hold off
    end
    ylabel('velocity')
    set(gca,'YLim',[-1e-7,1e-7]);
    set(gca,'XLim',[xx(1) xx(end)]);
    set(gca,'xtick',[])

    f=getframe(gcf);
    im = frame2im(f);
end