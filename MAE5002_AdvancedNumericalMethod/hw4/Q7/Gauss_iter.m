function [y_new,flag_iter,err] = Gauss_iter(A,b,y_new,err_flag)
    
    N = size(A,1);
    for flag_iter = 1:200000
        y_old = y_new;
        
        y_new(1) = (b(1) - A(1,2:N)*y_old(2:N))/A(1,1);
        for i = 2:N-1
            y_new(i) = b(i) - A(i,1:i-1)*y_old(1:i-1) - A(i,i+1:N)*y_old(i+1:N);
            y_new(i) = y_new(i)/A(i,i);
        end
        y_new(N) = (b(N) - A(N,1:N-1)*y_new(1:N-1))/A(N,N);
        
        err = norm(y_new-y_old,inf);
        if err < err_flag
            
            break;
        end
    end

end