%R=[0.5,sqrt(0.5),0.5;0.5,-sqrt(0.5),0.5;-sqrt(0.5),0,sqrt(0.5)];
R = [0.5,sqrt(0.5),0.5;0.5,sqrt(2)/6,-5/6;-sqrt(0.5),2/3,-sqrt(2)/6];
sigma = [10,5,-10;5,20,-15;-10,-15,-10];
sigma1 = R*sigma*R';

S=sigma;
I1 = sum(diag(sigma));
I2 = S(1,1)*S(2,2)+S(2,2)*S(3,3)+S(1,1)*S(3,3)-S(1,2)^2-S(1,3)^2-S(2,3)^2;
I3 = S(1,1)*S(2,2)*S(3,3)+2*S(1,2)*S(1,3)*S(2,3) -S(1,1)*S(2,3)^2-S(2,2)*S(1,3)^2-S(3,3)*S(1,2)^2;
syms  x;
eqn = x^3-I1*x^2+I2*x-I3==0;
lambda = double(solve(eqn,x));

[V,D]=eig(S);
V
D




