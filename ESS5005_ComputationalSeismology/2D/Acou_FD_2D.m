%% 2D Acoustic funtion by FD
clear all
%% parameter settings
% grid paras
WE = [-20000,20000];         % horizontal range left-right   /m
Z =  20000;               % depth range  /m

% physical property
c_z = [334,1430];      % velocity km/s. 0.344--air; 1.430--water; 1.500 sea
z_layer = 20;          % layer depth /km
 
% iteration information
dx = 10;                     % spatial step
flag_eps = 1;               % spatial-time stability control number
dt = flag_eps*dx/max(c_z);  % time step
N_t = 9000;                   % the number of iteration times for time   
N_x = (WE(2)- WE(1))/dx+1;  % the number of iteration times for X
N_z = Z/dx + 1;

% source parameters
N_source = 2;
time_s = [20,25;0,5];            % the occuring time of the source, start and end if needed
amp_s =  [1;2];                 % the amplitude of the source
loc_s = [-10000,0;10000,0];       % the source location (xs,zs) /km
type_s = [3;3];                 % basic function of source. 1--delta function; 2--rampfunction; 3--unistep

%% generate mesh

tt = 0:dt:N_t*dt;
XX = WE(1):dx:WE(2);
ZZ = 0:dx:Z;

%% generate source-time function and 

for i =1 : N_source
    s_t{i} =  source(time_s(i,:),amp_s(i),tt,type_s(i),i);
    x_s_index(i) = find(XX == loc_s(i,1));
    z_s_index(i) = find(ZZ == loc_s(i,2));
end

%% initialization for time and space

% time
P_bef = zeros(length(ZZ),length(XX));               % displacement field P(t-dt)
P_now = zeros(length(ZZ),length(XX));               % displacement field P(t)
for i = 1:N_source
    P_now(z_s_index(i),x_s_index(i)) = double(s_t{i}(1));
end
P_after = zeros(length(ZZ),length(XX));             % displacement field P(t+dt)

% % space
% Ps_bef = zeros(length(ZZ),length(XX));               % displacement field P(x-dx,z-dz)
% Ps_now = zeros(length(ZZ),length(XX));               % displacement field P(x,z)
% for i = 1:N_source
%     Ps_now(z_s_index,x_s_index) = double(s_t{i}(1));
% end
% Ps_after = zeros(length(ZZ),length(XX));             % displacement field P(x+dx,z+dz)

%% iteration for each time and space
P_total{1} = P_now;
flag_max = max(max(P_now));
flag_min = min(min(P_now));

for nt = 1:N_t
    % contribution of x direction
    d2P = zeros(length(ZZ),length(XX));
    for zz = 2:N_z-1
        if ZZ(zz) <= z_layer
            c = c_z(1);
        else
            c = c_z(2);
        end
        for xx =2:N_x-1
            d2P_x = (P_now(zz,xx+1)-2*P_now(zz,xx)+P_now(zz,xx-1))/dx^(2);
            d2P_z = (P_now(zz+1,xx)-2*P_now(zz,xx)+P_now(zz-1,xx))/dx^(2);
            d2P(zz,xx) = ( d2P_z+d2P_x )*dt^(2)*c^(2);
        end
    end

    % renew time,space contribution without source
    P_after = 2*P_now-P_bef + d2P;

    % add source influence
    for i = 1:N_source
        P_after(z_s_index(i),x_s_index(i)) = P_after(z_s_index(i),x_s_index(i)) + double(s_t{i}(nt));
    end

    % renew for iteration
    P_bef =  P_now;
    P_now = P_after;
    P_total{nt+1} = P_now;

    % renew max and min flag
    if flag_min > min(min(P_now))
        flag_min = min(min(P_now));
    end
    if flag_max < max(max(P_now))
        flag_max = max(max(P_now));
    end

end

%% plot
GifPlot(tt,P_total,dt,XX,ZZ,flag_min,flag_max)
