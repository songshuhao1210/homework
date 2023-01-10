function [Q] = boundary_Q(Q,xx,yy)
    nx = length(xx);
    ny = length(yy);
    for k = 1:3
        Q(1,:,k) = Q(2,:,k);Q(ny,:,k) = Q(ny-1,:,k);
        Q(:,1,k) = Q(:,2,k);Q(:,nx,k) = Q(:,nx-1,k);
    end
end