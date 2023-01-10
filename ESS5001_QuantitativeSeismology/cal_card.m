function [u1,u2,u3] = cal_card(r,xita,phi,t,alpha,beta,rho)
    gama1 = cos(xita)*sin(phi);
    gama2 = sin(xita)*sin(phi);
    gama3 = cos(phi);

    % integral part
    syms tau
    yy(tau) = source_time(t-tau)*tau;
    integ = double(int(yy,tau,[r/alpha,r/beta]));

    u1 = 3*gama1*gama3/4/pi/rho/r^3*integ ...
        + gama1*gama3/4/pi/rho/alpha^2/r*source_time(t-r/alpha)...
        - gama1*gama3/4/pi/rho/beta^2/r*source_time(t-r/beta) ;

    u2 = 3*gama2*gama3/4/pi/rho/r^3*integ ...
        + gama2*gama3/4/pi/rho/alpha^2/r*source_time(t-r/alpha)...
        - gama2*gama3/4/pi/rho/beta^2/r*source_time(t-r/beta) ;

    u3 = (3*gama3*gama3-1)/4/pi/rho/r^3*integ ...
        + gama3*gama3/4/pi/rho/alpha^2/r*source_time(t-r/alpha)...
        - (gama3*gama3-1)/4/pi/rho/beta^2/r*source_time(t-r/beta) ;
end