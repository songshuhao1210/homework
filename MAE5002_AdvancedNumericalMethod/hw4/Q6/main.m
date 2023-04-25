format long

A = [10,-7,0,1;-3,2.09999,6,2;5,-1,5,-1;2,1,0,2;];

%A = [3,5,6;2,4,5;1,2,3];

%P = [0,0,1,0;0,1,0,0;0,0,0,1;1,0,0,0];
%A = [2,1,1,2;2,2,2,3;4,2,4,3;0,0,6,-1];

%A = [1,2,6;4,8,-1;-2,3,5];

b = [8;5.900001;5;1];

[L_real,U_real,P_real] = lu(A);
[L_direct,U_direct] = direct_lu(A)
[L_indirect,U_indirect,P_indirect] = indirect_lu(A)
%err_matrix_direct = norm(L_direct*U_direct-A)
%err_matrix_indirect = norm(P_indirect*L_indirect*U_indirect-A)


A_det = det(P*L*U);
A_direct_det = det(L_direct*U_direct)
A_indirect_det = det(inv(P_indirect)*L_indirect*U_indirect)

x_direct = backward(U_direct,forward(L_direct,b))
x_indirect = backward(U_indirect,forward(L_indirect,b,P_indirect))
x_real = inv(A)*b

err_matrix_direct = norm(x_direct-x_real,inf)
err_matrix_indirect = norm(x_indirect-x_real,inf)



%det(L_direct)

