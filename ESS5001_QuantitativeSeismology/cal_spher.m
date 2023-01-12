function [ur,uxi,uphi] = cal_spher(r,xita,phi,t,alpha,beta,rho)
   t
   [u1,u2,u3] = cal_card(r,xita,phi,t,alpha,beta,rho);
   ur = u1*sin(xita)*cos(phi) + u2*sin(xita)*sin(phi)+u3*cos(xita);
   uxi = u1*cos(xita)*cos(phi) + u2*cos(xita)*sin(phi)-u3*sin(xita);
   uphi = -u1*sin(phi) + u2*cos(phi);
end