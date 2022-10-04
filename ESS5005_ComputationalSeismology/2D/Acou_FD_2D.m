%% 2D Acoustic funtion by FD
clear all
%% parameter settings
% grid paras
WE = [-2000,2000];         % horizontal range left-right   /m
Z =  2000;               % depth range  /m

% physical property


% iteration and velocity information
dx = 10;                     % spatial step
flag_eps = 0.1;               % spatial-time stability control number
N_t = 8000;                   % the number of iteration times for time   
N_x = (WE(2)- WE(1))/dx+1;  % the number of iteration times for X
N_z = Z/dx + 1;
XX = WE(1):dx:WE(2);
ZZ = 0:dx:Z;

type_c = 2;
value_c = [344,900,1430;0,500,1000];    % type 2
%value_c = [10,20,50000]; % type 3
cc = Velocity(value_c,type_c,XX,ZZ);

dt = flag_eps*dx/max(max(cc));  % time step
tt = 0:dt:N_t*dt;

% source parameters
N_source = 1;
time_s = [0,0;0,0];            % the occuring time of the source, start and end if needed
amp_s =  [10;2];                 % the amplitude of the source
loc_s = [0,0;10,0];       % the source location (xs,zs) /km
type_s = [1;1];                 % basic function of source. 1--delta function; 2--unistep; 3--single frequency source


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

%% iteration for each time and space
P_total{1} = P_now;
flag_max = max(max(P_now));
flag_min = min(min(P_now));

for nt = 2:N_t
    % contribution of x direction
    d2P = zeros(length(ZZ),length(XX));
    for zz = 2:N_z-1
        for xx =2:N_x-1
            d2P_x = (P_now(zz,xx+1)-2*P_now(zz,xx)+P_now(zz,xx-1))/dx^(2);
            d2P_z = (P_now(zz+1,xx)-2*P_now(zz,xx)+P_now(zz-1,xx))/dx^(2);
            d2P(zz,xx) = ( d2P_z+d2P_x )*dt^(2)*cc(zz,xx)^(2);
        end
    end

    % renew time,space contribution without source
    P_after = 2*P_now-P_bef + d2P;

    % free surface boundary
    P_after(1,:) = 0;

    % add source influence
    for i = 1:N_source
        P_after(z_s_index(i),x_s_index(i)) = P_after(z_s_index(i),x_s_index(i)) + double(s_t{i}(nt))*dt^(2);
    end



    % renew for iteration
    P_bef =  P_now;
    P_now = P_after;
    P_total{nt} = P_now;

    % renew max and min flag
    if flag_min > min(min(P_now))
        flag_min = min(min(P_now));
    end
    if flag_max < max(max(P_now))
        flag_max = max(max(P_now));
    end

    d2PS{nt} = d2P;

end

%% plot
GifPlot(tt,P_total,dt,XX,ZZ,type_c,value_c,-0.01,0.01)
