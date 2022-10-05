function [] = GifPlot(tt,dt,speed,im)
% GifPlot : plot .git for visualization
    

    filename = 'Wavefield.gif'; % Specify the output file name
    for idx = 1:length(im)
        [A,map] = rgb2ind(im{idx},256);
        if idx == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',speed*dt);
        end
    end

    
end