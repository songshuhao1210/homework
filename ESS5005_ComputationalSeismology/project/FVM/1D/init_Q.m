function [Q] = init_Q(xx,xc)
    sigma = 200;
    Q = exp(-1/sigma^2.*(xx-xc).^2);
end