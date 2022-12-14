function [eqs] = equation(p,x,flag)
    R = 8.31;
    T = 1800;
    dG_A = cal_G(p,T,1);
    dG_B = cal_G(p,T,2);
    lamb_A = exp(-dG_A/R/T);
    lamb_B = exp(-dG_B/R/T);
    if flag == 1
        eqs = (1-lamb_A)/(lamb_B-lamb_A)-x;
    else
        eqs = lamb_B*(1-lamb_A)/(lamb_B-lamb_A)-x;
    end
end