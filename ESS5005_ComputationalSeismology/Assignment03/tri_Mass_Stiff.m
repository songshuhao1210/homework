function [M,D] = tri_Mass_Stiff(N_tot,Nx,Ny,dx,flag_plot_grid,path)
    % generate mass and stiff matrix by triangular basis
    %% plot grid
    % valid only for 
    if flag_plot_grid == 1
        xx = 1:Nx;
        yy = 1:Ny;
        I = meshgrid(xx,yy);
        plot(xx,I,'k')
        title("Triangular Grid")
        xlim([1,Nx])
        ylim([1,Ny])
        hold on
        plot(I,yy,'k')

        for i = 1:Nx-1
            line([1 i+1],[i+1 1],'Color','k');
            line([i+1 Nx],[Nx i+1],'Color','k');
        end
        saveas(gcf,[path,'grid_tri.png'])
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

