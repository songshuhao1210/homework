function [] = Plot_sub(path,N_plot,im)
    filenow=pwd;
    cd(path)
    a = im{round(N_plot/5)};
    b = im{round(N_plot*2/5)};
    c = im{round(N_plot*3/5)};
    d = im{round(N_plot*4/5)};
    %a=imread(strcat('field_',num2str(round(N_plot/5)),'.png'));
    %b=imread(strcat('field_',num2str(round(N_plot*2/5)),'.png'));
    %c=imread(strcat('field_',num2str(round(N_plot*3/5)),'.png'));
    %d=imread(strcat('field_',num2str(round(N_plot*4/5)),'.png'));
    M=[a,b;c,d];%横排
    imshow(M)
    saveas(gcf,'field.png')
    set(gcf,'unit','centimeters','position',[1,2,4*10,15])

    cd(filenow)


end