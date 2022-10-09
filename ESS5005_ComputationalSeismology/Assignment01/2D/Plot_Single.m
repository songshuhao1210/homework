function [im] = Plot_Single(XX,ZZ,tt,cc,value_c,type_c,source_prars,P_now,nt,flag_min,flag_max,im,flag_im,fig,path,N_plot)
%UNTITLED4 此处提供此函数的摘要
%   此处提供详细说明
    
    ratio = int32(length(XX)/length(ZZ));
    imagesc(XX',ZZ',P_now);
    hold on
    colorbar;
    set(gca,'CLim',[flag_min,flag_max])
    set(gca,'xaxislocation','top')
    set(gcf,'unit','centimeters','position',[1,2,ratio*10,10])
    axis ij
    title(['2D Acoustic pressure field,  t = ' num2str(tt(nt)),'s' ])
    xlabel('x direction /km')
    ylabel('y direction /km')
    hold on
    if type_c == 2
        for i = 2:size(value_c,2)
            line([XX(1),XX(end)],[value_c(2,i),value_c(2,i)],'linestyle','-')
        end
    elseif type_c == 3
        contour(XX,ZZ,cc,'black','ShowText','on')
        
    end
    
    for j = 1:source_prars{1}
        plot(source_prars{4}(j,1),source_prars{4}(j,2),'r*')
    end

    drawnow
    frame = getframe(fig);
    im{flag_im} = frame2im(frame);
    hold  off


%     if flag_im == round(N_plot/5) || flag_im == round(N_plot*2/5) || flag_im == round(N_plot*3/5) || flag_im == round(N_plot*4/5)
%         saveas(gcf,strcat(path,'field_',num2str(flag_im),'.png'))
%     end

    

end