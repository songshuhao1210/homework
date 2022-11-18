function [M,D] = tri_int_format(idx,Nx,N_tot,dx,flag_format)
    % flag_format: 1--diagonal component, 2--common
    %   
%     if idx == 1
%         indx_points = [idx+1,idx,idx+Nx+1];
%         [m1,d1] = cal_int(indx_points,Nx,dx,2,2);
%         indx_points = [idx+Nx,idx+Nx+1,idx];
%         [m2,d2] = cal_int(indx_points,Nx,dx,3,3);
%         M = m1+m2;
%         D = d1+d2;
%     elseif idx == N_tot
%         indx_points = [idx-1,idx,idx-Nx-1];
%         [m1,d1] = cal_int(indx_points,Nx,dx,2,2);
%         indx_points = [idx-Nx,idx-Nx-1,idx];
%         [m2,d2] = cal_int(indx_points,Nx,dx,3,3);
%         M = m1+m2;
%         D = d1+d2;
    M = 0;
    D = 0;
    if flag_format == 1

        if  mod(idx-1,Nx)~=0 && idx-Nx-1 >= 0
            indx_points = [idx-1,idx,idx-Nx-1]; % 1
            [m,d] = tri_cal_int(indx_points,Nx,dx,2,2);
            M = M + m;D = D + d;
            indx_points = [idx-Nx,idx-Nx-1,idx];% 2
            [m,d] = tri_cal_int(indx_points,Nx,dx,3,3);
            M = M + m;D = D + d;
        end
        if idx+Nx <= N_tot && mod(idx,Nx)~=0
            indx_points = [idx+1,idx,idx+Nx+1]; % 4
            [m,d] = tri_cal_int(indx_points,Nx,dx,2,2);
            M = M + m;D = D + d;
            indx_points = [idx+Nx,idx+Nx+1,idx];% 5
            [m,d] = tri_cal_int(indx_points,Nx,dx,3,3);
            M = M + m;D = D + d;
        end
        if  idx-Nx-1 >= 0 && mod(idx,Nx)~=0
            indx_points = [idx,idx+1,idx-Nx];   % 3
            [m,d] = tri_cal_int(indx_points,Nx,dx,1,1);
            M = M + m;D = D + d;
        end
        if mod(idx-1,Nx) && idx+Nx <= N_tot
            indx_points = [idx,idx-1,idx+Nx];   % 6
            [m,d] = tri_cal_int(indx_points,Nx,dx,1,1);
            M = M + m;D = D + d;
        end

    elseif flag_format == 2 % 3+4

        if mod(idx,Nx)~=0 && idx-Nx-1 >= 0
            indx_points = [idx,idx+1,idx-Nx];   % 3
            [m,d] = tri_cal_int(indx_points,Nx,dx,1,2);
            M = M + m;D = D + d;
        end
        if idx+Nx <= N_tot && mod(idx,Nx)~=0
            indx_points = [idx+1,idx,idx+Nx+1]; % 4
            [m,d] = tri_cal_int(indx_points,Nx,dx,1,2);
            M = M + m;D = D + d;
        end
    
    elseif flag_format == 3 % 4+5   

        if idx+Nx <= N_tot && mod(idx,Nx)~=0
            indx_points = [idx+1,idx,idx+Nx+1]; % 4
            [m,d] = tri_cal_int(indx_points,Nx,dx,2,3);
            M = M + m;D = D + d;
            indx_points = [idx+Nx,idx+Nx+1,idx];% 5
            [m,d] = tri_cal_int(indx_points,Nx,dx,2,3);
            M = M + m;D = D + d;
        end

    else                    % 5+6

        if idx+Nx <= N_tot && mod(idx,Nx)~=0
            indx_points = [idx+Nx,idx+Nx+1,idx];% 5
            [m,d] = tri_cal_int(indx_points,Nx,dx,1,3);
            M = M + m;D = D + d;
        end
        if mod(idx-1,Nx) && idx+Nx <= N_tot
            indx_points = [idx,idx-1,idx+Nx];   % 6
            [m,d] = tri_cal_int(indx_points,Nx,dx,1,3);
            M = M + m;D = D + d;
        end

    end
        
    
end