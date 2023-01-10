function [im] = iteration(xx,Nt,dx,dt,c,rho,flag_form,flag_v,xc,speed)
    nx = length(xx);
    Q = init_Q(xx);
    im{1} = plot_main(xx,Q,flag_v,xc,0);
    flag_plot = 2;
    if flag_form == 1
        % Upwind
        for ti = 2:Nt
            Q_old = Q;
            for i = 2:nx-1
                A = [0,-rho*c(i)^2;-1/rho,0];
                dQ = Q_old(:,i)-Q_old(:,i-1);
                Q(:,i) = Q_old(:,i) - dt/dx.*A*dQ;
            end
            % absorbing
            Q = boundary_Q(Q,xx);
            % plot
            if mod(ti,speed) == 0
                im{flag_plot} = plot_main(xx,Q,flag_v,xc,(ti-1)*dt);
                flag_plot = flag_plot + 1;
            end
        end
    else
        % Lax
        for ti = 2:Nt
            Q_old = Q;
            for i = 2:nx-1
                A = [0,-rho*c(i)^2;-1/rho,0];
                dQ_l = Q_old(:,i) - Q_old(:,i-1);
                dQ_r = Q_old(:,i+1) - Q(:,i);
                Q(:,i) = Q_old(:,i) - dt/2/dx .* A * (dQ_l + dQ_r) + 0.5*(dt/dx)^2.*A*A*(dQ_r-dQ_l);
            end
            % absorbing
            Q = boundary_Q(Q,xx);
            % plot
            if mod(ti,speed) == 0
                im{flag_plot} = plot_main(xx,Q,flag_v,xc,(ti-1)*dt);
                flag_plot = flag_plot + 1;
            end
        end
    end
end