function [flag_fig_num,pr] = PSM(flag_ratio,nx,ny,nt,dx,dt,c,H,f,ixs,iys,flag_source_type,title,dt2,flag_fig_num,filename,path,ixr,iyr)


    % PSM
    %
    %% setting k based on Nyquist wavenumber
    k_max = pi/dx;
    dk_x = k_max/(nx/2);
    dk_y = k_max/(ny/2);
    
    k_x = 1:nx;
    k_x(1:nx/2) = dk_x.*k_x(1:nx/2);
    k_x(nx/2+1:end) = k_x(1:nx/2) - k_max;
    k_x = -k_x.^2;
    
    k_y = 1:ny;
    k_y(1:ny/2) = dk_y.*k_y(1:ny/2);
    k_y(ny/2+1:end) = k_y(1:ny/2) - k_max;
    k_y = -k_y.^2;
    
    %% PSM iteration
    disp(['begin ',title])
    tic
        % gif setting
    gif_2dPSM=zeros(ny,nx,nt/dt2);
    flag_gif = 1;
    
    p = zeros(ny,nx);
    d2p_x = p;
    d2p_y = p;
    p_old = p;
    
    pr = [];
    for i = 1:nt
        % spatial contribution
        for j = 1:ny
            F_x = fft(p(j,:));
            F_x = k_x.*F_x;
            d2p_x(j,:) = real(ifft(F_x));
        end
        for j = 1:nx
            F_y = fft(p(:,j));
            F_y = k_y'.*F_y;
            d2p_y(:,j) = real(ifft(F_y));
        end
        p_new=2*p-p_old+c.^2.*dt^2.*(d2p_x+d2p_y);
    
        % source contribution

        %  source is placed on a grid:
	    %    1/4  1/2  1/4
	    %    1/2   1   1/2
	    %    1/4  1/2  1/4

        ss = source_time(f,i*dt,flag_source_type)*dt^2;
        p_new(ny-iys,ixs)=p_new(ny-iys,ixs) + ss;

        p_new(ny-iys-1,ixs)=p_new(ny-iys-1,ixs) + ss;
        p_new(ny-iys+1,ixs)=p_new(ny-iys+1,ixs) + ss;
        p_new(ny-iys,ixs-1)=p_new(ny-iys,ixs-1) + ss;
        p_new(ny-iys,ixs+1)=p_new(ny-iys,ixs+1) + ss;

        p_new(ny-iys-1,ixs-1)=p_new(ny-iys-1,ixs-1) + ss;
        p_new(ny-iys-1,ixs+1)=p_new(ny-iys-1,ixs+1) + ss;
        p_new(ny-iys+1,ixs-1)=p_new(ny-iys+1,ixs-1) + ss;
        p_new(ny-iys+1,ixs+1)=p_new(ny-iys+1,ixs+1) + ss;

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
        pr = [pr p(iyr,ixr)];
       
    end
    toc
    disp(['end ',title])

    gif_2dPSM = gif_2dPSM / max(max(max(gif_2dPSM)));


    %% plot
    flag_fig_num = plot_main(1,nx,ny,nt,dt,H,gif_2dPSM,dt2,flag_fig_num,title,path,filename);
    
end