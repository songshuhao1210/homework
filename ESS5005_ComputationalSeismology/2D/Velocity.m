function [cc] = Velocity(value_v,type_v,XX,ZZ)
% Velovcity.m return the velocity model 
% type v: 1--homogeneous; 2--layer model; 3--c(x,z)
    
    cc = zeros(length(ZZ),length(XX));
    if type_v == 1
        cc = value_v;
    elseif type_v == 2
        for i = 2:size(value_v,2)
            z_start = find(ZZ == value_v(2,i-1));
            z_end = find(ZZ == value_v(2,i));
            cc(z_start:z_end,:) = value_v(1,i-1);
        end
        cc(z_end:end,:) = value_v(1,end);
    else
        % c = Ax+Bz+C
        for ix =1:length(XX)
            for iz = 1:length(ZZ)
                cc(iz,ix) = value_v(1) *XX(ix) + value_v(2)*ZZ(iz) + value_v(3);
            end
        end
    end

end