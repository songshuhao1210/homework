function [y_new,flag_iter,err] = Jacobi_iter(A,b,y_new,err_flag)

    for flag_iter = 1:2000000
        y_old = y_new;
        y_new = (b + (diag(A).*eye(size(A,1))-A)*y_old )./ diag(A);
        err = norm(y_new-y_old,inf);
        if err < err_flag
            
            break;
        end
    end

end