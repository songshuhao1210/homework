function [Q] = boundary_Q(Q,xx,yy)
    nx = length(xx);
    ny = length(yy);
    Q(1,:,:) = Q(2,:,:);Q(ny,:,:) = Q(ny-1,:,:);
    Q(:,1,:) = Q(:,2,:);Q(:,nx,:) = Q(:,nx-1,:);
end