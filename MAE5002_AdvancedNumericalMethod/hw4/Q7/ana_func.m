function [y] = ana_func(eps,a,n)
    x = linspace(0,1,n+1);
    x = x(2:end-1);
    y = (1-a)/(1-exp(-1/eps)).*(1-exp(-x./eps)) + a.*x;
end