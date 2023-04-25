function [L,U,P] = indirect_lu(A)
    N = size(A,1);
    L = eye(N);
    P = eye(N);

    for j = 1:N-1
        [p,index] = max(abs(A(j:N,j)));
        P_this = Trans(N,j,index+j-1);
        A = P_this*A;
        P = P_this*P;
        if j > 1
            L = P_this*L*P_this;
        end
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