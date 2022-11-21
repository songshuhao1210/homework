function [Nt,dt] = N_t(Nx,eps,ka,dx)
    Nt = floor(0.5/eps*(Nx/10)^2*Nx);
    dt = eps*dx^2 / ka;
end