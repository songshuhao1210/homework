function [im] = plot_main(xx,Q_up,Q_Lax,Q_theory,t)
    plot(xx,Q_up)
    hold on
    plot(xx,Q_Lax)
    plot(xx,Q_theory,'black--')
    hold off
    
    ylabel('x')
    ylabel('Amplitude')
    set(gcf,'Units','centimeter','Position',[20 5 12 6]);
    title([ 't=',num2str(t),' s'])
    set(gca,'YLim',[-0.5,2]);
    set(gca,'XLim',[xx(1) xx(end)]);
    set(gca,'xtick',[])
    legend('Upwind','Lax','Theory')
    
    % GIF
    f=getframe(gcf);
    im = frame2im(f);
end