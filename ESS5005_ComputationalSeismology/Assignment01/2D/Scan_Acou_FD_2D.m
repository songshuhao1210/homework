%% 2D Acoustic function by FD, scan version
clear all
%% parameters

flag_bound = [1,1,1,1;0,0,0,0];
%flag_eps = [0.5];
%flag_eps = [0.6,0.4,0.3,0.2,0.1];
type_c = [2];
dx = [1,5,10,20];

folder_fig = 'test/';

%% loop to compute
flag_inf = zeros(size(flag_bound,2),length(flag_eps),length(type_c),length(dx));

for i = 1:size(flag_bound,1)
    flag_bound_this = flag_bound(i,:);
    for j = 1:length(flag_eps)
        flag_eps_this = flag_eps(j);
        for k = 1:length(type_c)
            type_c_this = type_c(k);
            for l = 1:length(dx)
                dx_this = dx(l);
                flag_inf(i,j,k,l) = Scan(flag_eps_this,type_c_this,flag_bound_this,dx_this,folder_fig);
            end
        end
    end
end

save(strcat(folder_fig,"flag_inf.mat"),"flag_inf")
save(strcat(folder_fig,"flag_eps.mat"),"flag_eps")