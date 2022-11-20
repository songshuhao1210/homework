function [M,D] = sqr_int_format(idx,Nx,N_tot,dx,flag_format)
% judge each M_ij, D_ij
    M = 0;
    D = 0;
    if flag_format == 1 % center M_ii, D_ii

        if  mod(idx-1,Nx)~=0 && idx-Nx-1 >= 0
            indx_points = [idx-1,idx,idx-Nx,idx-Nx-1]; % 1
            [m,d] = sqr_cal_int(indx_points,Nx,dx,2,2);
            M = M + m;D = D + d;
        end
        if  idx-Nx-1 >= 0 && mod(idx,Nx)~=0
            indx_points = [idx,idx+1,idx-Nx+1,idx-Nx]; % 2
            [m,d] = sqr_cal_int(indx_points,Nx,dx,1,1);
            M = M + m;D = D + d;
        end
        if  idx+Nx <= N_tot && mod(idx,Nx)~=0
            indx_points = [idx+Nx,idx+Nx+1,idx+1,idx]; % 3
            [m,d] = sqr_cal_int(indx_points,Nx,dx,4,4);
            M = M + m;D = D + d;
        end
        if mod(idx-1,Nx) && idx+Nx <= N_tot
            indx_points = [idx+Nx-1,idx+Nx,idx,idx-1]; % 4
            [m,d] = sqr_cal_int(indx_points,Nx,dx,3,3);
            M = M + m;D = D + d;
        end

    elseif flag_format == 2 % 2+3

        if  idx-Nx-1 >= 0 && mod(idx,Nx)~=0
            indx_points = [idx,idx+1,idx-Nx+1,idx-Nx]; % 2
            [m,d] = sqr_cal_int(indx_points,Nx,dx,1,2);
            M = M + m;D = D + d;
        end
        if  idx+Nx <= N_tot && mod(idx,Nx)~=0
            indx_points = [idx+Nx,idx+Nx+1,idx+1,idx]; % 3
            [m,d] = sqr_cal_int(indx_points,Nx,dx,3,4);
            M = M + m;D = D + d;
        end

    else                    % 3+4

        if  idx+Nx <= N_tot && mod(idx,Nx)~=0
            indx_points = [idx+Nx,idx+Nx+1,idx+1,idx]; % 3
            [m,d] = sqr_cal_int(indx_points,Nx,dx,1,4);
            M = M + m;D = D + d;
        end
        if mod(idx-1,Nx) && idx+Nx <= N_tot
            indx_points = [idx+Nx-1,idx+Nx,idx,idx-1]; % 4
            [m,d] = sqr_cal_int(indx_points,Nx,dx,2,3);
            M = M + m;D = D + d;
        end

    end
        
    
end