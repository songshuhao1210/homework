function [cor] = ind_cor(indx,Nx)
     % return (y,x)
     cor = zeros(2,1);
     if mod(indx,Nx) == 0
        cor(1) = indx/Nx;
        cor(2) = Nx;
     else
        cor(1) = floor(indx/Nx)+1;
        cor(2) = mod(indx,Nx);
     end
end