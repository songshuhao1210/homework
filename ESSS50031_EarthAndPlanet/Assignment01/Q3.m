close  all

R1 = 3480000;
R2 = 6371000;
I = 8.04e37;
M= 5.97e24;
G=6.67e-11;

%% density
A = zeros(2,2);
b  =  zeros(2,1);
A(1,1) = 1;
A(2,1) = 1;
A(1,2) = (R2/R1)^5-1;
A(2,2) = (R2/R1)^3-1;

b(1) = 15*I/8/pi/R1^5;
b(2) = 3*M/4/pi/R1^3;
x = inv(A)*b;

%% presure
Pcmb =  4\3*pi*G*(x(1)-x(2))*x(2)*R1^3*(1/R1-1/R2) + 2/3*pi*G*x(2)^2*(R2^2-R1^2);
Pcenter  = Pcmb + 2/3*G*pi*x(1)^2*R1^2;
%% plot g(r)
rho1 = x(1);
rho2 = x(2);

r = 0.1:1000:R2;
Mr = 4/3*rho1*pi*r.^3 .* (r<=R1) + (4/3*(rho1-rho2)*pi*R1^3+4/3*pi*rho2*r.^3).*(r>R1);
gr = G.*Mr./r.^2;

figure('Position',[10 100 900 350])
subplot(1,2,1)
plot(r,gr,'r')
title('Gravity(g) change with radius(r)')
xlabel('r /m')
ylabel('g /m/s^2')


%% plot P(r)
Pcmb =  4\3*pi*G*(x(1)-x(2))*x(2)*R1^3*(1/R1-1/R2) + 2/3*pi*G*x(2)^2*(R2^2-R1^2);
Pr= (4\3*pi*G*(x(1)-x(2))*x(2)*(r.^2-r.^3/R2) + 2/3*pi*G*x(2)^2*(R2^2-r.^2)) .*(r>R1) ...
    +(Pcmb+2/3*G*pi*x(1)^2*(R1^2-r.^2)).*(r<=R1);

subplot(1,2,2)
plot(r,Pr,'b')
title('Pressure(P) change with Radius(r)')
xlabel('r /m')
ylabel('P /Pa')
saveas(gcf,'plots_with_r.png')

rr_0=R1*(2*(rho1-rho2)/rho2)^(1/3);

