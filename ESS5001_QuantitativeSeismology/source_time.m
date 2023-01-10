function [x] = source_time(t)
    a0 = 0.3;
    w0 = 2*pi;
    x = exp(-a0*t)*sin(w0*t)*heaviside(t);

end