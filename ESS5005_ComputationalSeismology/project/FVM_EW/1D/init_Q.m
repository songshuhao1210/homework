function [Q] = init_Q(xx)
    sigma = 200;
    xc = xx(end)/2;
    Q = zeros(2,length(xx));
    Q(1,:) = exp(-1/sigma^2.*(xx-xc).^2);
end