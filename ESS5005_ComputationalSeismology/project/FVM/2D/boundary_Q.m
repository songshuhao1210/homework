function [Q] = boundary_Q(Q,xx,yy)
    nx = length(xx);
    ny = length(yy);
    %Q(1,:) = Q(2,:);
    Q(ny-1,:) = Q(ny-2,:);
    %Q(:,1) = Q(:,2);
    Q(:,nx-1) = Q(:,nx-2);
    Q(1,:) = 0; Q(nx,:) = 0;
    Q(:,1) = 0; Q(:,ny) = 0;
end