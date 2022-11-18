function [m,d] = tri_cal_int(indx_points,Nx,dx,flag_1,flag_2)
    % return m_ij

    %% get three points coordinates
    cors = zeros(3,2);
    for i = 1:3
        cors(i,:) = ind_cor(indx_points(i),Nx);
    end

    %% calculate Jacobi matrix
    jacobi = zeros(2,2);
    jacobi(1,1) = cors(2,2)-cors(1,2);
    jacobi(1,2) = cors(3,2)-cors(1,2);
    jacobi(2,1) = cors(2,1)-cors(1,1);
    jacobi(2,2) = cors(3,1)-cors(1,1);
    jacobi = jacobi*dx;
    
    %% represent Two basic functions
%     if flag_1 == 1 && flag_2 == 1       % 11
%         m = 1/12;
%     elseif flag_1 == 2 && flag_2 == 2   % 22
%         m = 1/12;
%     elseif flag_1 == 3 && flag_2 == 3   % 33
%         m = 1/12;
%     elseif flag_1 + flag_2 == 3         % 12
%         m = 1/24;
%     elseif flag_1 + flag_2 == 4         % 13
%         m = 1/24;
%     else                                % 23
%         m = 1/24;
%     end
%     m = m*det(jacobi);
    syms a b
    phi_1 = tri_shape_func(flag_1,a,b);
    phi_2 = tri_shape_func(flag_2,a,b);

    %% find m and d integral
    m = int(int(phi_1*phi_2*det(jacobi),b,0,1-a),a,0,1);

    d_phi_1(1,1) = diff(phi_1,a);
    d_phi_1(2,1) = diff(phi_1,b);
    d_phi_2(1,1) = diff(phi_2,a);
    d_phi_2(2,1) = diff(phi_2,b);

    y = (1./jacobi'*d_phi_1)'*(1./jacobi'*d_phi_2)*det(jacobi);

    d = int(int(y,a,0,1-b),b,0,1);


end