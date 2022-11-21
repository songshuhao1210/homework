function [m,d] = sqr_cal_int(indx_points,Nx,dx,flag_1,flag_2)
    % calculate the an element m_ij, d_ij

    %% get three points coordinates
    xx = zeros(4,1);
    yy = zeros(4,1);
    for i = 1:4
        cor = ind_cor(indx_points(i),Nx);
        xx(i) = cor(2);
        yy(i) = cor(1);
    end

    %% calculate Jacobi matrix
    syms a b

    x = sqr_shape_func(1,a,b)*xx(1)+sqr_shape_func(2,a,b)*xx(2)+sqr_shape_func(3,a,b)*xx(3)+sqr_shape_func(4,a,b)*xx(4) ;
    y = sqr_shape_func(1,a,b)*yy(1)+sqr_shape_func(2,a,b)*yy(2)+sqr_shape_func(3,a,b)*yy(3)+sqr_shape_func(4,a,b)*yy(4) ;

    jacobi(1,1) = diff(x,a);% x,a
    jacobi(1,2) = diff(x,b);% x,b 
    jacobi(2,1) = diff(y,a);% y,a
    jacobi(2,2) = diff(y,b);% y,b
    jacobi = jacobi*dx;
    
    %% represent Two basic functions
    phi_1 = sqr_shape_func(flag_1,a,b);
    phi_2 = sqr_shape_func(flag_2,a,b);

    %% find m and d integral
    m = int(int(phi_1*phi_2*det(jacobi),a,-1,1),b,-1,1);

    d_phi_1(1,1) = diff(phi_1,a);
    d_phi_1(2,1) = diff(phi_1,b);
    d_phi_2(1,1) = diff(phi_2,a);
    d_phi_2(2,1) = diff(phi_2,b);

    j_rev = inv(jacobi);
    

    y = d_phi_1'*j_rev *j_rev'*d_phi_2*det(jacobi);

    d = int(int(y,a,-1,1),b,-1,1);


    %% test


end