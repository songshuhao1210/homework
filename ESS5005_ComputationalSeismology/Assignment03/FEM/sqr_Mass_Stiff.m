function [M_D] = sqr_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path)
    % generate mass and stiff matrix by triangular basis
    %% plot grid
    % valid only for 
    if flag_plot_grid == 1
        xx = 1:Nx;
        yy = 1:Ny;
        I = meshgrid(xx,yy);
        plot(xx,I,'k')
        title("Square Grid")
        xlim([1,Nx])
        ylim([1,Ny])
        hold on
        plot(I,yy,'k')

        plot(xx,I,'ro')
        plot(I,yy,'ro')

        saveas(gcf,[path,'grid_sqr.png'])
        hold off
    end

    %% define sparse matrix
    M = sparse(N_tot,N_tot);
    D = sparse(N_tot,N_tot);
%     M = zeros(N_tot,N_tot);
%     D = zeros(N_tot,N_tot);

    %% renew point by point
    for idx = 1:N_tot-1
        % center
        [m,d] = sqr_int_format(idx,Nx,N_tot,dx,1);
        M(idx,idx) = m;D(idx,idx) = d;

        % near 4 points
        [m,d] = sqr_int_format(idx,Nx,N_tot,dx,2);           % 2+3
        M(idx+1,idx) = m;M(idx,idx+1) = m;
        D(idx+1,idx) = d;D(idx,idx+1) = d;
        if idx-Nx-1>=0
            [m,d] = sqr_int_format(idx,Nx,N_tot,dx,5);       % 1
            M(idx,idx-Nx+1) = m;M(idx-Nx+1,idx) = m;
            D(idx,idx-Nx+1) = d;D(idx-Nx+1,idx) = d;
        end
        if idx + Nx <= N_tot
            [m,d] = sqr_int_format(idx,Nx,N_tot,dx,3);       % 3+4
            M(idx,idx+Nx) = m;M(idx+Nx,idx) = m;
            D(idx,idx+Nx) = d;D(idx+Nx,idx) = d;
        end
        if idx + Nx < N_tot
            [m,d] = sqr_int_format(idx,Nx,N_tot,dx,4);       % 3
            M(idx,idx+Nx+1) = m;M(idx+Nx+1,idx) = m;
            D(idx,idx+Nx+1) = d;D(idx+Nx+1,idx) = d;
        end

    end

    % center for last one
    [m,d] = sqr_int_format(N_tot,Nx,N_tot,dx,1);
    M(N_tot,N_tot) = m;
    D(N_tot,N_tot) = d;

    M_D{1} = M;
    M_D{2} = D;


end