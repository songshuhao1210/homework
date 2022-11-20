function [phi] = sqr_shape_func(flag_shape,a,b)
    if flag_shape == 1
        phi = (0.5-a)*(0.5-b);
    elseif flag_shape == 2
        phi = (0.5+a)*(0.5-b);
    elseif flag_shape == 3
        phi = (0.5+a)*(0.5+b);
    else
        phi = (0.5-a)*(0.5+b);
    end
end