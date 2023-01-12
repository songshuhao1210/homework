%% parameters
xitaS = 0:pi/12:pi;
phi = 0;
r = 50;

tt = 0:0.02:30;
%% Elastic constant
alpha = 5;
beta = 2.9;
rho = 2.7;


%% Parallel computation setting
CoreNum = 39;        % number of cores to be called
if isempty(gcp('nocreate'))
    p = parpool(CoreNum);
end

%% calculate
% xx = zeros(size(tt));
% for i=0:50
%     xx(i+1) = source_time(tt(i+1));
% end
% plot(tt,xx)

urS = zeros(length(tt),length(xitaS));
uxiS = zeros(length(tt),length(xitaS));
uphiS = zeros(length(tt),length(xitaS));
for j = 1:length(xitaS)
    xita = xitaS(j);

    parfor i = 1:length(tt)
        [ur,uxi,uphi] = cal_spher(r,xita,phi,tt(i),alpha,beta,rho);
        urS(i,j) = double(ur);
        uxiS(i,j) = double(uxi);
        uphiS(i,j) = double(uphi);
    end

end




delete(p)
%%
[all_themes, all_colors] = GetColors();

%%


figure(1)
leg = [];
for i = 1:length(xitaS)
    plot(tt,uxiS(:,i)+0.00005*i,'LineWidth',2)
    %set(gca, 'colororder', all_themes{i+4});
    hold on
end
hold off
set(gcf,'Units','centimeter','Position',[5 1 30 13]);
set(gca,'XLim',[tt(1) tt(end)]);
set(gca,'ytick',[])
ylabel('Amplitude')
xlabel('time/s')
title('Theory seismogram Uθ')
legend('θ=180','θ=165','θ=150','θ=135','θ=120','θ=105','θ=90','θ=75','θ=60','θ=45','θ=30','θ=15','θ=0','Location','SouthWest')
saveas(gcf,['radidationPattern_xita_',num2str(r),'.png'])

figure(2)
for i = 1:length(xitaS)
    plot(tt,urS(:,i)+0.00005*i,'LineWidth',2)
    %set(gca, 'colororder', all_themes{i+4});
    hold on
end

hold off

set(gcf,'Units','centimeter','Position',[5 20 30 13]);
set(gca,'XLim',[tt(1) tt(end)]);
set(gca,'ytick',[])
ylabel('Amplitude')
xlabel('time/s')
title('Theory seismogram Ur')
%legend('θ=0','θ=15','θ=30','θ=45','θ=60','θ=75','θ=90','θ=105','θ=120','θ=135','θ=150','θ=165','θ=180','Location','SouthWest')
legend('θ=180','θ=165','θ=150','θ=135','θ=120','θ=105','θ=90','θ=75','θ=60','θ=45','θ=30','θ=15','θ=0','Location','SouthWest')
saveas(gcf,['radiationPattern_r_',num2str(r),'.png'])

