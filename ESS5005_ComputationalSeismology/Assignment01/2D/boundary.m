function [P_after] = boundary(dx,dt,cc,P_bef,P_now,P_after,flag_control)
%boundary.m: boundary settingsx
%
% flag_control: 0--none;1--left;2--right;3--up;4--down

    AA = dt/dx * cc;
    if flag_control(1) == 0
        P_after(:,1) = 0;
    else
                A = AA(:,1);
        P_after(:,1) = (2-2.*A-A.^(2)).*P_now(:,1) + 2*A.*(1+A).*P_now(:,2)...
            -A.^(2).*P_now(:,3)+(2.*A-1).*P_bef(:,1)-2.*A.*P_bef(:,2);
    end
        

    if flag_control(2) == 0 %right
        P_after(end,:) = 0;
    else
        A = AA(:,end);
        P_after(:,end) = (2-2.*A-A.^(2)).*P_now(:,end) + 2*A.*(1+A).*P_now(:,end-1)...
            -A.^(2).*P_now(:,end-2)+(2.*A-1).*P_bef(:,end)-2.*A.*P_bef(:,end-1);
    end
    
    if flag_control(3) == 0 %up
        P_after(1,:) = 0;
    else
        A = AA(1,:);
        P_after(1,:) = (2-2.*A-A.^(2)).*P_now(1,:) + 2*A.*(1+A).*P_now(2,:)...
            -A.^(2).*P_now(3,:)+(2.*A-1).*P_bef(1,:)-2.*A.*P_bef(2,:);
    end
    
    if flag_control(4) == 0 %down
        P_after(end,:) = 0;
    else
        A = AA(end,:);
        P_after(end,:) = (2-2.*A-A.^(2)).*P_now(end,:) + 2*A.*(1+A).*P_now(end-1,:)...
            -A.^(2).*P_now(end-2,:)+(2.*A-1).*P_bef(end,:)-2.*A.*P_bef(end-1,:);
    end


end