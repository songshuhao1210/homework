function [A,b] = gen_mat(eps,a0,n)
    N = n-1;
    h = 1/n;
    A = zeros(N,N);
    b = zeros(N,1);
    
    % generate A and b
    num_a_1 = eps;
    num_a_2 = -(2*eps+h);
    num_a_3 = eps+h;
    num_b_1 = a0*h^2;
    num_b_2 = a0*h^2 - eps - h;

    A(1,1) = num_a_2;
    A(1,2) = num_a_3;
    b(1) = num_b_1;
    A(end,end) = num_a_2;
    A(end,end-1) = num_a_1;
    b(N) = num_b_2;

    for i = 2:N-1
        A(i,i-1) = num_a_1;
        A(i,i) = num_a_2;
        A(i,i+1) = num_a_3;
        b(i) = num_b_1;
    end
    % generate B


end