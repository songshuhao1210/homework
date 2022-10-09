%% 2D Acoustic funtion by FD
clear all
%% parameter settings
% grid paras
WE = [-3000,3000];              % horizontal range left-right   /m
Z =  3000;                      % depth range  /m

% iteration, velocity and source information
    % spatial steps
dx = 5;                        % spatial step
flag_eps = 0.5;                 % spatial-time stability control number
N_x = (WE(2)- WE(1))/dx+1;      % the number of iteration times for X
N_z = Z/dx + 1;                 % the number of iteration times for Z
XX = WE(1):dx:WE(2);            % meshgrid X
ZZ = 0:dx:Z;                    % meshgrid Z

    % velocity model:
type_c = 2;                     % velocity type; 
if type_c == 1
    value_c = 344;              % 1--homogeneous;
elseif type_c == 2
    value_c = [344,1430,2320;0,800,2000]; %   2--layers; value_c(1,:)=velocity , value_c(2,:) = start depth
elseif type_c == 3
    value_c = [0.1,0.2,1000];    % 3--2D anisotropic; c(z,x) = value_c(1)*xx+value_v(2)*zz+valuec_(3)
else
    disp("wrong velocity type")
end
cc = Velocity(value_c,type_c,XX,ZZ);    % velocity model


    % time steps
t_end =4;
dt = flag_eps*dx/max(max(cc));          % time step
N_t = round(t_end/dt);                     % the number of iteration times for time   
tt = 0:dt:N_t*dt;                       % meshgrid t
speed = 50;                            % speed of gif

    % source parameters
source_paras{1} = 2;                    % the number of sources
source_paras{2} = [0,tt(end);1,tt(end)];            % the occuring time of the source, start and end if needed
source_paras{3} = [1000;1000];               % the amplitude of the source
%source_paras{4} = [3*dx,3*dx;1000,1000];           % the source location (xs,zs) /km
source_paras{4} = [-1000,2000;1000,1000];
source_paras{5} = [3;3];                % basic function of source. 1--delta function; 2--unistep; 3--single frequency source
source_paras{6} = [1;3];               % extra information, i.e. f0


    % boundary parameters;
%flag_bound = [0,0,0,0];                 % [left,right,up,down], 0--free bound, 1--absorbing bound
flag_bound = [1,1,0,1]; 
if flag_bound(1) ==0 
    type_bound = 'free';
else
    type_bound = 'absorb';
end

% out put file setting
folder_fig = 'offitial/';
path = [folder_fig,' eps=',num2str(flag_eps),' dx=',num2str(dx),' v_type=',num2str(type_c),' bound=',type_bound,'/'];
%path = [folder_fig,'eps=',flag_eps,'dx=',dx,'v_type=',type_c,'v_val=',value_c,'nsource=',source_paras{1},'bound',type_bound];
if exist(folder_fig) == 0
    mkdir(folder_fig)
end
if exist(path) ~= 0
    rmdir(path,'s')
end
mkdir(path)
save(strcat(path,'source_paras.mat'),"source_paras")
save(strcat(path,'value_c.mat'),"value_c")


%% generate source-time function

for i =1 : source_paras{1}
    s_t{i} =  source(tt,i,path,source_paras);
    x_s_index(i) = find(XX == source_paras{4}(i,1));
    z_s_index(i) = find(ZZ == source_paras{4}(i,2));
end

%% initialization for time and space

P_bef = zeros(length(ZZ),length(XX));               % displacement field P(t-dt)
P_now = zeros(length(ZZ),length(XX));               % displacement field P(t)
for i = 1:source_paras{1}
    P_now(z_s_index(i),x_s_index(i)) = double(s_t{i}(1))*dt^(2);
end
P_after = zeros(length(ZZ),length(XX));             % displacement field P(t+dt)

%% iteration for each time and space
flag_max = 0.001;
flag_min = -0.001;
flag_inf = 0.1;

flag_speed = speed;         % speed--to plot
flag_im = 1;                % the index of single plotings

fig = figure(1);
im = {};                    % plotings
N_plot = round(N_t/speed);
plot_flag = 1;
for nt = 2:N_t
    [P_after,flag_inf] = FD_2D(XX,ZZ,dx,dt,cc,source_paras,s_t,nt,x_s_index,z_s_index,P_bef,P_now,flag_bound,flag_inf);
    P_bef = P_now;
    P_now = P_after;

    if flag_speed == speed
        flag_speed = 1;
        im = Plot_Single(XX,ZZ,tt,cc,value_c,type_c,source_paras,P_now,nt,flag_min,flag_max,im,flag_im,fig,path,N_plot);
        flag_im = flag_im + 1;
    else
        flag_speed = flag_speed + 1;
    end

end
close;

save(strcat(path,'flag_inf.mat'),"flag_inf")

%% plot
Plot_Gif(dt,speed,im,path)
Plot_sub(path,N_plot,im)

