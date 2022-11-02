function [a] = loadHeight(nx,ny,ixs,iys)
    % load height data H(x,y)

    figure(1)
    fid  = fopen( 'bathy.out.linux','rb' );
    fid2 = fopen( 'height.dat','wb' );
    a = fread( fid, [nx,ny],'float32' );
    a = fliplr(a);
    a = a';
    fwrite( fid2, a, 'float32' );
    fclose( fid  );
    fclose( fid2 );

    imagesc(a); 
    hold on
    plot(ixs,ny-iys,'rp',... 
        'LineWidth',2,...      
        'MarkerSize',8,...
        'MarkerFaceColor',[1,0,0])
    colorbar('horiz');
    colormap('bone');
    axis equal;
    axis tight;%使坐标轴的最大值最小值与数值一致
    set( gca,'yDir','reverse' ); %Y轴倒转
    hold  off
end