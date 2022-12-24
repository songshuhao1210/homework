function [im] = iteration(xx,yy,Nt,dx,dt,c,flag_form,flag_plot)
    nx = length(xx);
    ny = length(yy);
    Q = init_Q(xx,yy);
    im{1} = plot_main(xx,yy,Q,flag_plot);
    if flag_form == 1
        % Upwind
        for ti = 2:Nt
            Q_old = Q;
            dQ = zeros(size(Q_old));
            for i = 2:ny-1
                for j = 2:nx - 1
                    dQ(i,j) = 2*Q_old(i)-Q_old(i-1,j)-Q_old(i,j-1); 
                end
            end
            Q = Q_old - dt/dx*dQ.*c;
            % absorbing
            Q = boundary_Q(Q,xx,yy);
            % plot
            im{ti} = plot_main(xx,yy,Q,flag_plot);
        end
    else
        % Lax
        for ti = 2:Nt
            Q_old = Q;
            dQ = zeros(size(Q_old));
            dQ_1 = dQ;
            dQ_2 = dQ;
            for i = 2:ny-1
                for j = 2:nx - 1
                    dQ_1(i,j) = Q_old(i+1,j)  + Q_old(i-1,j) + Q_old(i,j+1)  + Q_old(i,j-1) - 4*Q_old(i,j);
                    dQ_2(i,j) = Q_old(i+1,j) - Q_old(i-1,j) + Q_old(i,j+1) - Q_old(i,j-1);
                end
            end
            Q = Q_old - dt/dx/2.*dQ_2.*c + 0.5*(dt/dx)^2.*dQ_1.*c.^2;
            % absorbing
            Q = boundary_Q(Q,xx,yy);
            % plot
            im{ti} = plot_main(xx,yy,Q,flag_plot);
        end
    end
end