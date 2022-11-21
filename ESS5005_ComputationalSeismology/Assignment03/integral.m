syms a b

phi_1 = (1-a)*(1+b)/4;
phi_2 = (1-a)*(1+b)/4;





d_phi_1(1,1) = diff(phi_1,a);
d_phi_1(2,1) = diff(phi_1,b);
d_phi_2(1,1) = diff(phi_2,a);
d_phi_2(2,1) = diff(phi_2,b);
j_rev  = [2,0;0,-2];
jacobi = [1/2,0;0,-1/2];

y1 =  phi_2*phi_1*det(jacobi);
y2 = (j_rev*d_phi_1)'*(j_rev*d_phi_2)*det(jacobi);

m = int(int(y1,a,-1,1),b,-1,1)
d = int(int(y2,a,-1,1),b,-1,1)