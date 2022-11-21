function [R] = R_vec(Nx,Ny,N_tot,dx,kappa,xita)
    % generate grid form of xita and R
    xita_mat = reshape(xita,Ny,Nx)';
    R = sparse(N_tot,1);
    R(1) = kappa/dx * (xita_mat(2,1)+xita_mat(1,2)-2*xita_mat(1,1));
    R(N_tot) = kappa/dx * (xita_mat(Ny,Nx-1)+xita_mat(Ny-1,Nx)-2*xita_mat(Ny,Nx));
end