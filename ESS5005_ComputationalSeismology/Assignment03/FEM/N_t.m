function [Nt,dt] = N_t(Nx,eps,ka,dx,flag_len)
    if flag_len == 1
        Nt = floor(0.5/eps*(Nx/10)^2*Nx);
    else
        Nt = floor(0.1/eps*(Nx/10)^2*Nx);
    end
    dt = eps*dx^2 / ka;
end