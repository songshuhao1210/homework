function [filename,filename_mat] = file_name(dx,eps,Nx,flag_grid,flag_pde_format)

    if flag_grid == 3
        filename =  ['tri_eps_',num2str(eps),'_Nx_',num2str(Nx),'_dx_',num2str(dx)];
        filename_mat =  ['tri_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
    else
        filename =  ['sqr_eps_',num2str(eps),'_Nx_',num2str(Nx),'_dx_',num2str(dx)];
        filename_mat =  ['sqr_Nx_',num2str(Nx),'_dx_',num2str(dx),'.mat'];
    end
    
    if flag_pde_format == 1
        filename = [filename,'_explicit'];
    else
        filename = [filename,'_implicit'];
    end

end