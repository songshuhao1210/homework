close all
%%
X = 0:0.01:0.3;
p = zeros(length(X),2);
for i = 1:length(X)
    xi = X(i);
    fun1 = @(x)equation(x,xi,1);
    fun2 = @(x)equation(x,xi,2);
    p(i,1) = fsolve(fun1,0);
    p(i,2) = fsolve(fun2,0);
end

%%
plot(X,p(:,1))
hold on
plot(X,p(:,2))
xlim([0 0.3])
ylim([0 18])
xlabel('Mole fraction of Fe2SiO4')
ylabel("Pressure (GPa)")
text(0.14,8,"Olivine")
text(0.13,16,"Wadsleyite")
hold off
saveas(gcf,'phase_xp.png')