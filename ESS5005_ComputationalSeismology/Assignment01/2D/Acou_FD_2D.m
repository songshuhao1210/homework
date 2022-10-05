%% 2D Acoustic funtion by FD
clear all
%% parameter settings
% grid paras
WE = [-6000,6000];              % horizontal range left-right   /m
Z =  3000;                      % depth range  /m

% iteration, velocity and source information
    % spatial steps
dx = 10;                        % spatial step
flag_eps = 0.1;                 % spatial-time stability control number
N_t = 6000;                     % the number of iteration times for time   
N_x = (WE(2)- WE(1))/dx+1;      % the number of iteration times for X
N_z = Z/dx + 1;                 % the number of iteration times for Z
XX = WE(1):dx:WE(2);            % meshgrid X
ZZ = 0:dx:Z;                    % meshgrid Z

    % velocity model:
type_c = 2;                     % velocity type; 
if type_c == 1
    value_c = 344;              % 1--homogeneous;
elseif type_c == 2
    value_c = [344,900,1430;0,800,2000]; %   2--layers; value_c(1,:)=velocity , value_c(2,:) = start depth
elseif type_c == 3
    value_c = [10,20,50000];    % 3--2D anisotropic; c(z,x) = value_c(1)*xx+value_v(2)*zz+valuec_(3)
else
    disp("wrong velocity type")
end
cc = Velocity(value_c,type_c,XX,ZZ);    % velocity model

    % time steps
dt = flag_eps*dx/max(max(cc));          % time step
tt = 0:dt:N_t*dt;                       % meshgrid t
speed = 100;                            % speed of gif

    % source parameters
source_paras{1} = 2;                    % the number of sources
source_paras{2} = [0,tt(end);0,tt(end)];            % the occuring time of the source, start and end if needed
source_paras{3} = [1000;1000];               % the amplitude of the source
source_paras{5} = [dx,dx;1000,1000];           % the source location (xs,zs) /km
source_paras{6} = [3;3];                % basic function of source. 1--delta function; 2--unistep; 3--single frequency source
source_paras{7} = [1;10];               % extra information, i.e. f0

%% generate source-time function

for i =1 : source_paras{1}
    s_t{i} =  source(source_paras{2}(i,:),source_paras{3}(i),tt,source_paras{6}(i),i,source_paras{7}(i,:));
    x_s_index(i) = find(XX == source_paras{5}(i,1));
    z_s_index(i) = find(ZZ == source_paras{5}(i,2));
end

%% initialization for time and space

P_bef = zeros(length(ZZ),length(XX));               % displacement field P(t-dt)
P_now = zeros(length(ZZ),length(XX));               % displacement field P(t)
for i = 1:source_paras{1}
    P_now(z_s_index(i),x_s_index(i)) = double(s_t{i}(1))*dt^(2);
end
P_after = zeros(length(ZZ),length(XX));             % displacement field P(t+dt)

%% iteration for each time and space
flag_max = 0.01;
flag_min = -0.01;

flag_speed = 100;           % 100--to plot
flag_im = 1;                % the index of single plotings

fig = figure;
im = {};                    % plotings
for nt = 2:N_t
    [P_after] = FD_2D(XX,ZZ,dx,dt,cc,source_paras,s_t,nt,x_s_index,z_s_index,P_bef,P_now);
    P_bef = P_now;
    P_now = P_after;

    if flag_speed == speed
        flag_speed = 1;
        im = SinglePlot(XX,ZZ,tt,value_c,type_c,source_paras,P_now,nt,flag_min,flag_max,im,flag_im,fig);
        flag_im = flag_im + 1;
    else
        flag_speed = flag_speed + 1;
    end

end
close;

%% plot
GifPlot(tt,dt,speed,im)
