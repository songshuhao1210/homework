function [im,im_s,a] = iteration(xx,yy,Nt,dx,dt,c,rho,f,flag_form,flag_v,yc,speed,x,d)
    
    a = zeros(1,Nt);

%     CoreNum = 1;        % number of cores to be called
%     if isempty(gcp('nocreate'))
%         p = parpool(CoreNum);
%     end


    nx = length(xx);
    ny = length(yy);
    Q = init_Q(xx,yy);
    [a(1),Q] = source(Q,xx,yy,0,f);
    [im{1},im_s{1}] = plot_main(xx,yy,Q,flag_v,yc,x,d,0);
    flag_plot = 2;


    if flag_form == 1
        % Upwind
        for ti = 2:Nt
            Q_old = Q;
            for j = 2:nx-1
                for i = 2:ny-1
                    mu = rho*c(i,j)^2;
                    A = [0,0,-mu; 0,0,0 ; -1/rho,0,0];
                    B = [0,0,0;0,0,-mu;0,-1/rho,0];
                    %dQ = Q_old(i,j,:)-Q_old(i-1,j,:)-Q_old(i,j-1,:);
                    dQ_x = zeros(3,1);
                    dQ_y = zeros(3,1);
                    for k = 1:3
                        dQ_x(k) = Q_old(i,j,k)-Q_old(i-1,j,k);
                        dQ_y(k) = Q_old(i,j,k)-Q_old(i,j-1,k);
                    end
                    F = dt/dx.*(A*dQ_x+B*dQ_y);
                    for k = 1:3
                        Q(i,j,k) = Q_old(i,j,k) - F(k);
                    end
                    %Q(i,j,:) = Q_old(i,j,:) - dt/dx.*A*dQ;

                    if i==j

                    end
                end
            end
            % absorbing
            Q = boundary_Q(Q,xx,yy);
            [a(ti-1),Q] = source(Q,xx,yy,(ti-1)*dt,f);
            % plot
            if mod(ti,speed) == 0
                [im{flag_plot},im_s{flag_plot}] = plot_main(xx,yy,Q,flag_v,yc,x,d,(ti-1)*dt);
                flag_plot = flag_plot + 1;
            end
        end
    else
        % Lax
        for ti = 2:Nt
            Q_old = Q;
            tic
            for j = 2:nx-1
                for i = 2:ny-1
                    mu = rho*c(i,j)^2;
                    A = [0,0,-mu; 0,0,0 ; -1/rho,0,0];
                    B = [0,0,0;0,0,-mu;-0,-1/rho,0];
                    dQ_l = zeros(3,1);dQ_r = zeros(3,1);
                    dQ_u = zeros(3,1);dQ_d = zeros(3,1);
                    for k = 1:3
                        dQ_d(k) = Q_old(i,j,k) - Q_old(i-1,j,k);
                        dQ_u(k) = Q_old(i+1,j,k) - Q_old(i,j,k);
                        dQ_l(k) = Q_old(i,j,k) - Q_old(i,j-1,k);
                        dQ_r(k) = Q_old(i,j+1,k) - Q_old(i,j,k);
                    end
                    F1 = dt/2/dx .* (A*(dQ_l + dQ_r)+B*(dQ_u + dQ_d));
                    F2 = 0.5*(dt/dx)^2.*((A*A)*(dQ_r - dQ_l)+...
                        (B*B)*(dQ_u - dQ_d));
                    for k = 1:3
                        Q(i,j,k) = Q_old(i,j,k) - F1(k)+F2(k);
                    end
                    %Q(:,i) = Q_old(:,i) - dt/2/dx .* A * (dQ_l + dQ_r) + 0.5*(dt/dx)^2.*A*A*(dQ_r-dQ_l);
                end
            end
            % absorbing
            [a(ti-1),Q] = source(Q,xx,yy,(ti-1)*dt,f);
            Q = boundary_Q(Q,xx,yy);
            % plot
            if mod(ti,speed) == 0
                [im{flag_plot},im_s{flag_plot}] = plot_main(xx,yy,Q,flag_v,yc,x,d,(ti-1)*dt);
                flag_plot = flag_plot + 1;
            end
            toc
        end
    end

    %delete(p)
end