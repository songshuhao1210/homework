function [Q] = boundary_Q(Q,xx,flag_bound)
    nx = length(xx);
    if flag_bound == 1
        % absorb
        Q(1) = Q(2);Q(nx) = Q(nx-1);
    else
        % period
        Q(1) = Q(nx-2);
    end
end