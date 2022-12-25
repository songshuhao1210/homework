function [Q] = init_Q(xx,yy)
    sigma = 20;
    x0 = xx(end)/2;
    y0 = yy(end)/2;
    Q = zeros(length(yy),length(xx),3);
%     for i = 2:length(yy)-1
%         for j = 2:length(xx)-1
%             Q(i,j,1) = exp(-1/sigma^2.*((xx(j)-x0)^2 + (yy(i) - y0)^2 ));
%             %Q(i,j,2) = exp(-1/sigma^2.*((xx(j)-x0)^2 + (yy(i) - y0)^2 ));
%         end
%     end
end