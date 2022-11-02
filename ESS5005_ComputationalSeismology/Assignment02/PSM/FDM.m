function [flag_fig_num] = FDM(flag_FDM,nx,ny,nt,dx,dt,c,H,f,ixs,iys,title,dt2,flag_fig_num,filename,path)


    % FDM_2D
    %
    %% PSM iteration
    disp(['begin ',title])
    tic
        % gif setting
    gif_2dPSM=zeros(ny,nx,nt/dt2);
    flag_gif = 1;
    
    p = zeros(ny,nx);
    p_old = p;
    p_new = p;
    
    for i = 1:nt

        % spatial contribution
        for ix = 2:nx-1
            for iy = 2:ny-1
                V = c(iy,ix)^2*dt^2/dx^2;
                if flag_FDM == 2 || ix == 2 || ix == nx-3 || iy ==2 || iy == ny-3
                    p_new(iy,ix) = 2.0*(1.0 + -2.0*V)*p(iy,ix) - p_old(iy,ix)...
                      + 1.0*V*(p(iy,ix+1) + p(iy,ix-1) + p(iy+1,ix) + p(iy-1,ix));
                else
                    p_new(iy,ix) = (2.0 + -5.0*V)*p(iy,ix) - p_old(iy,ix)...
                      + 1.0*V*(-1.0/12.0*(p(iy+2,ix)+p(iy-2,ix)+p(iy,ix+2)+p(iy,ix-2)) ...
                                      + 4.0/3.0*(p(iy+1,ix)+p(iy-1,ix)+p(iy,ix+1)+p(iy,ix-1)) );
                end
            end
        end

        % source contribution
        p_new(ny-iys,ixs)=p_new(ny-iys,ixs) + source(f,i*dt)*dt^2;

        % boundary condition
        p_new(1,:)=0;
        p_new(:,1)=0;
        p_new(ny,:)=0;
        p_new(:,nx)=0;

        % renew
        p_old = p;
        p = p_new;
    
        % save single
        if mod(i,dt2) == 0 
            gif_2dPSM(:,:,flag_gif)=p;
            flag_gif = flag_gif+1;
        end
       
    end
    toc
    disp(['end ',title])
    %% plot
    flag_fig_num = plot_main(nx,ny,nt,dt,H,gif_2dPSM,dt2,flag_fig_num,title,path,filename);
    
end