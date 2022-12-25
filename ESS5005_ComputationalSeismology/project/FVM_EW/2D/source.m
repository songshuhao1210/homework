function [a,Q] = source(Q,xx,yy,t,f)
    sigma = 20;
    x0 = xx(end)/2;
    y0 = yy(end)/2;
    t0 = 3/f;
    t = double(t);
    s = zeros(size(Q(:,:,3)));
    for i = 2:length(yy)-1
        for j = 2:length(xx)-1
            s(i,j) = exp(-1/sigma^2.*((xx(j)-x0)^2 + (yy(i) - y0)^2 ));
        end
    end
    
    a = -f*(t-t0)*exp(-((t-t0)*f)^2);
    s = -f*(t-t0)*exp(-((t-t0)*f)^2).*s;
    Q(:,:,3) = Q(:,:,3) + s;
    max(max(abs(s)))
end