function [phi] = tri_shape_func(flag_shape,a,b)
    if flag_shape == 1
        phi = 1-a-b;
    elseif flag_shape == 2
        phi = a;
    else
        phi = b;
    end
end