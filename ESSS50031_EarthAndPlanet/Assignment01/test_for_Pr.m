A = 2.2710e+17;
B=0.0024;
R1 = 3480000;
R2=6371000*2;
r=R1:1000:R2;
Pr1 = A./r-1./R2 ; 
Pr2 = 0.0024*(R2^2-r.^2);
Pr = Pr1 + Pr2;
plot(r,Pr,'black');
hold on
plot(r,Pr1,'r');
hold on
plot(r,Pr2,'b');