function [phi] = sqr_shape_func(flag_shape,a,b)
    if flag_shape == 1
        phi = (1-a)*(1-b)/4;
    elseif flag_shape == 2
        phi = (1+a)*(1-b)/4;
    elseif flag_shape == 3
        phi = (1+a)*(1+b)/4;
    else
        phi = (1-a)*(1+b)/4;
    end
end