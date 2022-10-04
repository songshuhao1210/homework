function [] = GifPlot(tt,P_total,dt,XX,ZZ,type_c,value_c,min,max)
% GifPlot : plot .git for visualization
    
    %[XX,ZZ] = meshgrid(X,Z);
    speed = 100;
    
    fig = figure;
    for idx = 1:speed:length(tt)-1
        imagesc(XX',ZZ',double(P_total{idx}));
        colorbar;
        set(gca,'CLim',[min,max])
        axis ij
        title(['2D Acoustic wave field,  t = ' num2str(tt(idx)) ])
        if type_c == 2
            for i = 2:size(value_c,2)
                hold on
                line([XX(1),XX(end)],[value_c(2,i),value_c(2,i)],'linestyle','-')
            end
            hold off
        end


        drawnow
        frame = getframe(fig);
        im{idx} = frame2im(frame);
    end
    close;

    filename = 'Wavefield.gif'; % Specify the output file name
    for idx = 1:speed:length(tt)-1
        [A,map] = rgb2ind(im{idx},256);
        if idx == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',speed*dt);
        end
    end

    
end