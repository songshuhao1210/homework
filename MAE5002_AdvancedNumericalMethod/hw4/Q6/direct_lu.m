function [L,U] = direct_lu(A)
    N = size(A,1);
    L = eye(N);

    for j = 1:N-1
        p = A(j,j);
        for i = j+1:N
            m = A(i,j) / p;
            A(i,:) = A(i,:) - m*A(j,:);
            L_this = eye(N);
            L_this(i,j) = -m;
            L= L*inv(L_this);
        end
    end
    U = A;

end