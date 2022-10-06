function [im] = SinglePlot(XX,ZZ,tt,cc,value_c,type_c,source_prars,P_now,nt,flag_min,flag_max,im,flag_im,fig)
%UNTITLED4 此处提供此函数的摘要
%   此处提供详细说明
    
    ratio = int32(length(XX)/length(ZZ));
    imagesc(XX',ZZ',P_now);
    hold on
    contour(XX,ZZ,cc,'black','ShowText','on')
    colorbar;
    set(gca,'CLim',[flag_min,flag_max])
    set(gca,'xaxislocation','top')
    set(gcf,'unit','centimeters','position',[1,2,ratio*10,10])
    axis ij
    title(['2D Acoustic wave field,  t = ' num2str(tt(nt)) ])
    if type_c == 2
        for i = 2:size(value_c,2)
            hold on
            line([XX(1),XX(end)],[value_c(2,i),value_c(2,i)],'linestyle','-')
            for j = 1:size(source_prars{5},1)
                plot(source_prars{5}(j,1),source_prars{5}(j,2),'r*')
            end
        end
        hold off
    end

    drawnow
    frame = getframe(fig);
    im{flag_im} = frame2im(frame);

end