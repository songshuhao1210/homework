%% parameters
xita = pi/6;
phi = 0;
r = 100;

tt = 0:0.05:50;
%% Elastic constant
alpha = 5;
beta = 2.9;
rho = 2.7;


%% Parallel computation setting
CoreNum = 30;        % number of cores to be called
if isempty(gcp('nocreate'))
    p = parpool(CoreNum);
end

%% calculate
% xx = zeros(size(tt));
% for i=0:50
%     xx(i+1) = source_time(tt(i+1));
% end
% plot(tt,xx)
urS = zeros(size(tt));
uxiS = zeros(size(tt));
uphiS = zeros(size(tt));
parfor i = 1:length(tt)
    [ur,uxi,uphi] = cal_spher(r,xita,phi,tt(i),alpha,beta,rho);
    urS(i) = double(ur);
    uxiS(i) = double(uxi);
    uphiS(i) = double(uphi);
end

delete(p)
%%
plot(tt,uxiS,'LineWidth',2)
hold on
plot(tt,urS,'LineWidth',2)
hold off
legend('Uθ','Ur')
set(gcf,'Units','centimeter','Position',[20 5 20 8]);
set(gca,'XLim',[tt(1) tt(end)]);
set(gca,'ytick',[])
ylabel('Amplitude')
xlabel('time/s')
title([ 'Theory seismogram; r =',num2str(r),' km'])
saveas(gcf,['seismogram_r_',num2str(r),'.png'])

