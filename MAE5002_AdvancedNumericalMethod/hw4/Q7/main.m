eps = 0.001
a = 0.5;
n = 100;

err_flag = 1e-6


y0 = linspace(0,1,n-1)';
[A,b] = gen_mat(eps,a,n);

[y_jac,flag_iter_jac,err_jac] = Jacobi_iter(A,b,y0,err_flag);

[y_gauss,flag_iter_gauss,err_gauss] = Gauss_iter(A,b,y0,err_flag);

flag_iter_jac
flag_iter_gauss

y0 = ana_func(eps,a,n)';

x = linspace(0,1,n+1);
x = x(2:end-1);



plot(x,y0,'black--')
hold on
plot(x,y_jac,'black*')
plot(x,y_gauss,'g')
legend({'Analytical solution','Jacobi','Gauss-Seidel'},'Location','northwest')
hold off
saveas(gca,'comparison.png')