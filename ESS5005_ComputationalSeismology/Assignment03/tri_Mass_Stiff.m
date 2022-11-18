function [M,D] = tri_Mass_Stiff(N_tot,Nx,dx)
    % generate mass and stiff matrix by triangular basis

    %% define sparse matrix
    M = sparse(N_tot,N_tot);
    D = sparse(N_tot,N_tot);


    %% renew point by point
    for idx = 1:N_tot-1
        % center
        [m,d] = tri_int_format(idx,Nx,N_tot,dx,1);
        M(idx,idx) = m;D(idx,idx) = d;

        % near 3 points
        [m,d] = tri_int_format(idx,Nx,N_tot,dx,2);           % 3+4
        M(idx+1,idx) = m;M(idx,idx+1) = m;
        D(idx+1,idx) = d;D(idx,idx+1) = d;
        if idx + Nx < N_tot
            [m,d] = tri_int_format(idx,Nx,N_tot,dx,3);       % 4+5
            M(idx,idx+Nx+1) = m;M(idx+Nx+1,idx) = m;
            D(idx,idx+Nx+1) = d;D(idx+Nx+1,idx) = d;
            [m,d] = tri_int_format(idx,Nx,N_tot,dx,4);       % 5+6
            M(idx,idx+Nx) = m;M(idx+Nx,idx) = m;
            D(idx,idx+Nx) = d;D(idx+Nx,idx) = d;
        end
    end

    % center for last one
    [m,d] = tri_int_format(N_tot,Nx,N_tot,dx,1);
    M(N_tot,N_tot) = m;
    D(N_tot,N_tot) = d;


end

