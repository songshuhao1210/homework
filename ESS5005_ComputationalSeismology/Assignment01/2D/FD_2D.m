function [P_after] = FD_2D(XX,ZZ,dx,dt,cc,source_paras,s_t,nt,x_s_index,z_s_index,P_bef,P_now)
%UNTITLED2 此处提供此函数的摘要
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

    % free surface boundary
    P_after(1,:) = 0;

    % add source influence
    for i = 1:source_paras{1}
        P_after(z_s_index(i),x_s_index(i)) = P_after(z_s_index(i),x_s_index(i)) + double(s_t{i}(nt))*dt^(2);
    end


end