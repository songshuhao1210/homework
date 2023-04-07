function [x] = forward(L,b,P)
    if(~exist('P','var'))
        P = eye(size(L,1));  
    end

    N = size(L,1);
    x = zeros(N,1);
    y = P*b;

    for i = 1:N
        x(i) = y(i);
        for j = 1:i-1
            x(i) = x(i) - x(j)*L(i,j);
        end
        x(i) = x(i)/L(i,i);
    end

end