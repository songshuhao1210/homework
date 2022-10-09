clear all
folder_fig = 'Stable/';
load([folder_fig,'flag_eps.mat']);
load([folder_fig,'flag_inf.mat']);
flag_bound = [1,1,1,1;0,0,0,0];
type_c = [1,2,3];

flag_plot = 1;
figure('Units','centimeter','Position',[12 6 30 15]);
index_plot = ['(a) ';'(b) ';'(c) ';'(d) ';'(e) ';'(f) '];
for i=1:size(flag_bound,1)

    if flag_bound(i,1) == 1
        bound = "absorb";
    else
        bound = "free";
    end
    
    for j = 1:length(type_c)

        if j == 1
            c_t = "homogeneous";
        elseif j == 2
            c_t = "layer";
        else
            c_t = "anisotropic";
        end

        for k=1:size(flag_inf,2)
            %filename = strcat(bound,'_velocity model=',c_t,'.png');

            if flag_inf(j,k,i)~=inf
                flag_start = k;
                break;
            end

        end


        if max(flag_inf(i,flag_start:end,j)) > 10*min(flag_inf(i,flag_start:end,j))
            subplot(size(flag_bound,1),length(type_c),flag_plot)
            semilogy(flag_eps(flag_start:end),flag_inf(i,flag_start:end,j),'r*')
            ylabel('max value in iteration (log axis)')
        else
            subplot(size(flag_bound,1),length(type_c),flag_plot)
            plot(flag_eps(flag_start:end),flag_inf(i,flag_start:end,j),'r*');
            ylabel('max value in iteration')
        end
        
        title(strcat(index_plot(flag_plot,:),'.  ',bound,' bound, ',c_t,' model'))
        set(gca,'XDir','reverse')
        xlabel('epsilon')

        flag_plot = flag_plot + 1;

    end


end
filename = 'stability.png';
saveas(gcf,strcat(folder_fig,filename));