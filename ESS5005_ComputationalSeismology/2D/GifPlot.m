function [] = GifPlot(tt,P_total,dt,X,Z,min,max)
% GifPlot : plot .git for visualization
    
    [XX,ZZ] = meshgrid(X,Z);
    
    fig = figure;
    for idx = 1:length(tt)
        pcolor(XX',ZZ',double(P_total{idx})');
        colorbar;
        set(gca,'CLim',[min,max])
        axis ij
        title(['2D Acoustic wave field,  t = ' num2str(tt(idx)) ])
        drawnow
        frame = getframe(fig);
        im{idx} = frame2im(frame);
    end
    close;

    filename = 'Wavefield.gif'; % Specify the output file name
    for idx = 1:length(tt)
        [A,map] = rgb2ind(im{idx},256);
        if idx == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',3);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',dt);
        end
    end

    
end