function [cor] = ind_cor(indx,Nx)
     cor = zeros(2,1);
     cor(1) = floor(indx/Nx)+1;
     cor(2) = mod(idx,Nx);
end