function [Q] = boundary_Q(Q,xx)
    nx = length(xx);
    Q(:,1) = Q(:,2);Q(:,nx) = Q(:,nx-1);
end