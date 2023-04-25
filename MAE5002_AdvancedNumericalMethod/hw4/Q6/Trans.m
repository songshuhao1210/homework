function [P] = Trans(N,a,b)
    P = eye(N);
    P(a,a) = 0;
    P(b,b) = 0;
    P(a,b) = 1;
    P(b,a) = 1;
end