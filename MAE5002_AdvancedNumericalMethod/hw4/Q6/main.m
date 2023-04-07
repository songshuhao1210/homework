A = [10,-7,0,1;-3,2.09999,6,2;5,-1,5,-1;2,1,0,2;];

%A = [3,5,6;2,4,5;1,2,3];

%P = [0,0,1,0;0,1,0,0;0,0,0,1;1,0,0,0];
%A = [2,1,1,2;2,2,2,3;4,2,4,3;0,0,6,-1];

%A = [1,2,6;4,8,-1;-2,3,5];

b = [8;5.900001;5;1];

[L,U,P] = lu(A);
[L1,U1] = direct_lu(A);
[L2,U2,P2] = indirect_lu(A);

A_det = det(P*L*U);
A1_det = det(L1*U1);
A2_det = det(P2*L2*U2);

x = backward(U,forward(L,b,P));
x1 = backward(U1,forward(L1,b));
x2 = backward(U2,forward(L2,b,P2));

xx = inv(A)*b;

det(L1)