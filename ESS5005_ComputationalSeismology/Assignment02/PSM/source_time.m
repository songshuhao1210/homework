function [s] = source_time(f,t,flag_source_type)
    
    syms x
    if flag_source_type == 1
        % Richer Wavelet
        t0 = 1/f;
        R(x)=(1-2*(pi*f*(x-t0))^2)*exp(-(pi*f*(x-t0))^2);
    else
        % Gaussian function
        t0 = 1.5/f;
        R(x)=-(x-t0)*exp(-((x-t0)*f*4)^2);
    end
    s = double(R(t));

end