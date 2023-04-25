function [x] = backward(U,b)
    N = size(U,1);
    x = zeros(N,1);
    y = b;

    for i = N:-1:1
        x(i) = y(i);
        for j = i+1:N
            x(i) = x(i) - x(j)*U(i,j);
        end
        x(i) = x(i)/U(i,i);
    end
    
end