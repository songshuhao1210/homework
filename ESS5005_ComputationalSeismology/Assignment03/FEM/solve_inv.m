function [xita] = solve_inv(M,D,ka,Nx,Ny,N_tot,eps,dx,flag_pde_format,flag_len)
    %% initialize temperature field
    xita_0 = 100;
    xita_old = ones(N_tot,1);
    xita_old = xita_0*xita_old;
    %xita_old = linspace(1,N_tot,N_tot);
    xita_old = bound(xita_old,Nx,Ny);

    %% set A,dt,Nt
    [Nt,dt] = N_t(Nx,eps,ka,dx,flag_len);
    R = R_vec(Nx,Ny,N_tot,dx,ka,xita_old);
    %R = sparse(N_tot,1);
    if flag_pde_format == 1
        A = M./dt;
    else
        A = M./dt + ka.*D;
    end

    %% gif setting
    xita=zeros(Nx,Ny,Nt);
    xita(:,:,1) = reshape(xita_old,Ny,Nx)'; 
    flag_gif = 1;
    %% iteration
    for i=1:Nt
        if flag_pde_format == 1
            b = (M./dt-ka.*D)*xita_old +  R;
        else
            b = M*xita_old./dt +  R;
        end
        
        xita_new = A\b;
        xita_new = bound(xita_new,Nx,Ny);
        xita_old = xita_new;
        
        % save for fig
        xita_mat  = reshape(xita_new,Ny,Nx)';
        xita(:,:,flag_gif)=xita_mat;
        flag_gif = flag_gif+1;
    
    end
    
end