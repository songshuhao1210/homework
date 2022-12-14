% field
a = zeros(1000,800);

% file i/o
fid = fopen('figures/slices.out','r');

%cl = [-4.0:0.2:4.0];
close all;

for i=1:40
   i
   a(:,:) = fread(fid,[1000,800],'float32');
   pcolor(a'); shading flat;
   axis ij;axis equal;
   colorbar('horiz');
   
   xlim([0 1000]);ylim([0 800]);
   
   if (i == 1)
     title('bathymetry');
     
     colormap(bone);
     %axis ij;axis equal;
     %xlim([0 500]);ylim([0 400]);
     saveas(gcf, 'figures/bathymetry', 'jpg');
     %print( gcf, '-depsc', 'figures/bathymetry'); % eps-format
     pause(2);
   else
     title(['i = ',num2str(i)]);
     
     % color map
     myColorMap = jet;     
     myColorMap(33, :) = [1 1 1];
     colormap(myColorMap); 
     caxis([-0.1 0.1]);
     saveas(gcf, ['figures/',num2str(i)], 'jpg');       
     %print( gcf, '-depsc', ['figures/',num2str(i)]); % eps-format
     %pause(0.1);
   end
end
fclose(fid);
