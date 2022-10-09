clear all
folder_fig = 'test/';
load([folder_fig,'flag_eps.mat']);
load([folder_fig,'flag_inf.mat']);
dx=[1,5,10,20];
flag_bound = [1,1,1,1];
type_c = [2];

flag_plot = 1;
figure('Units','centimeter','Position',[12 6 30 15]);
index_plot = ['(a) ';'(b) ';'(c) '];
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

                subplot(1,1,flag_plot)
                plot(dx,flag_inf(i,k,j,:),'r*');
                ylabel('max value in iteration')
                title(strcat(index_plot(flag_plot,:),'.  ',bound,' bound, ',c_t,' model'))
                xlabel('dx')

                flag_plot = flag_plot + 1;


        end
        
        

    end


end
filename = 'stability.png';
saveas(gcf,strcat(folder_fig,filename));