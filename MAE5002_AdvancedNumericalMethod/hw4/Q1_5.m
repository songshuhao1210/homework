%% 1
syms x
A = [x-2,-3,-2;-1,x-8,-2;2,14,x+3];
yy = det(A);




%% 3
A=[1,-1;1,1];
cond(A,inf)

%% 4-1
A = [1,2,3;2,4,5;3,5,6];
[L,U,P]=lu(A)
B = [1,0,0;-2/3,1,0;-1/3,-1/2,1];

%% 4-2
P = [0,0,0,1;0,1,0,0;1,0,0,0;0,0,1,0];
L = [1,0,0,0;1/2,1,0,0;0,0,1,0;1/2,0,-1/6,1];
U = [4,2,4,3;0,1,0,3/2;0,0,6,-1;0,0,0,1/3];
A = [2,1,1,2;2,2,2,3;4,2,4,3;0,0,6,-1];

[L,U,P]=lu(A)