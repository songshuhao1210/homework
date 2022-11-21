function [xita,t_1] = bound(xita,Nx,Ny)
    % corner temperature
    t_1 = 75;
    t_2 = 100;
    t_3 = 25;
    t_4 = 50;
   
    xita_mat = reshape(xita,Ny,Nx)';

    
    % boundary up
    xita_mat(1,:) = t_1 + (t_2-t_1)/(Nx-1).*linspace(0,Nx-1,Nx);

    % boundary down
    xita_mat(Ny,:) = t_3 + (t_4-t_3)/(Nx-1).*linspace(0,Nx-1,Nx);

    % boundary left
    xita_mat(:,1) = t_1 + (t_3-t_1)/(Ny-1).*linspace(0,Ny-1,Ny);

    % boundary right
    xita_mat(:,Nx) = t_2 + (t_4-t_2)/(Ny-1).*linspace(0,Ny-1,Ny);

    xita = reshape(xita_mat',[Ny*Nx,1]);
end