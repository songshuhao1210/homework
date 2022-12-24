function [Q] = init_Q(xx,yy)
    sigma = 10;
    x0 = xx(20);
    y0 = yy(20);
    Q = zeros(length(yy),length(xx));
    for i = 2:length(yy)-1
        for j = 2:length(xx)-1
            Q(i,j,1) = exp(-1/sigma^2.*((xx(j)-x0)^2 + (yy(i) - y0)^2 ));
        end
    end
end