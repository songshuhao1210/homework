function [indx] = cor_ind(cor,Nx)
    i = cor(1);
    j = cor(2);
    indx = (i-1)*Nx + j;
end