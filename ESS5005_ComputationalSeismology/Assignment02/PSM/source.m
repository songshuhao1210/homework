function [s] = source(f,t)
    % Richer Wavelet

    t0 = 1/f;

    syms x
    R(x)=(1-2*(pi*f*(x-t0))^2)*exp(-(pi*f*(x-t0))^2);

    s = R(t);
    
end