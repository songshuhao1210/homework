function [P_after,flag_inf] = FD_2D(XX,ZZ,dx,dt,cc,source_paras,s_t,nt,x_s_index,z_s_index,P_bef,P_now,flag_bound,flag_inf)
%FD_2D finite.m: differntial function for 2D problem
%   此处提供详细说明
    
    % contribution of x direction
    d2P = zeros(length(ZZ),length(XX));
    for zz = 2:length(ZZ)-1
        for xx =2:length(XX)-1
            d2P_x = (P_now(zz,xx+1)-2*P_now(zz,xx)+P_now(zz,xx-1))/dx^(2);
            d2P_z = (P_now(zz+1,xx)-2*P_now(zz,xx)+P_now(zz-1,xx))/dx^(2);
            d2P(zz,xx) = ( d2P_z+d2P_x )*dt^(2)*cc(zz,xx)^(2);
        end
    end

    % renew time,space contribution without source
    P_after = 2*P_now-P_bef + d2P;

    % add source influence
    for i = 1:source_paras{1}
        P_after(z_s_index(i),x_s_index(i)) = P_after(z_s_index(i),x_s_index(i)) + double(s_t{i}(nt))*dt^(2);
    end

    % boundary set
    P_after = boundary(dx,dt,cc,P_bef,P_now,P_after,flag_bound);


    % renew flag_inf
    if flag_inf < max(max(abs(P_after)))
        flag_inf = max(max(abs(P_after)));
    end


end