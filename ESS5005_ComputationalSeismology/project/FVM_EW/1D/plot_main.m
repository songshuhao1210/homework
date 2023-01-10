function [im] = plot_main(xx,Q,flag_v,xc,t)
    %set(gcf,'Units','centimeter','Position',[20 5 24 6]);
    set(gcf,'Units','centimeter','Position',[20 5 18 15]);
    subplot(2,1,1)
    plot(xx,Q(1,:),'blue')
    if flag_v == 2
        hold on
        line([xc,xc],[-1,1],'color','black','linestyle','--')
        text(xx(end)/2,0.75,'c1')
        text(xx(end)*5/6,0.75,'c2')
        hold off
    end
    ylabel('stress')
    set(gca,'YLim',[-1,1]);
    set(gca,'XLim',[xx(1) xx(end)]);
    set(gca,'xtick',[])

    subplot(2,1,2)
    plot(xx,Q(2,:),'red')
    if flag_v == 2
        hold on
        line([xc,xc],[-1.5e-7,1.5e-7],'color','black','linestyle','--')
        text(xx(end)/2,0.75*1.5e-7,'c1')
        text(xx(end)*5/6,0.75*1.5e-7,'c2')
        hold off
    end
    ylabel('velocity')
    set(gca,'YLim',[-1.5e-7,1.5e-7]);
    set(gca,'XLim',[xx(1) xx(end)]);
    set(gca,'xtick',[])

    sgtitle(['t = ',num2str(t),'s'])

    f=getframe(gcf);
    im = frame2im(f);
end