function [xita] = solve_inv(M,D,ka,Nx,Ny,N_tot,eps,dx)
    %% initialize temperature field
    xita_0 = 100;
    xita_old = ones(N_tot,1);
    xita_old = xita_0*xita_old;
    %xita_old = linspace(1,N_tot,N_tot);
    xita_old = bound(xita_old,Nx,Ny);

    %% set A,dt,Nt
    dt = eps*dx^2 / ka; % time step
    Nt = floor(1./eps*Nx);
    A = M./dt + ka.*D;
    R = R_vec(Nx,Ny,N_tot,dx,ka,xita_old);
    %R = sparse(N_tot,1);

    %% gif setting
    xita=zeros(Nx,Ny,Nt);
    xita(:,:,1) = reshape(xita_old,Ny,Nx)'; 
    flag_gif = 1;
    %% iteration
    for i=1:Nt
        b = M*xita_old./dt +  R;
        xita_new = A\b;
        xita_new = bound(xita_new,Nx,Ny);
        xita_old = xita_new;
        
        % save for fig
        xita_mat  = reshape(xita_new,Ny,Nx)';
        xita(:,:,flag_gif)=xita_mat;
        flag_gif = flag_gif+1;
    
    end
    
end