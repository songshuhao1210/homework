function [s] = source(time_s0,amp_s,time,type_s,number)
    % This function SOURCE generate the source time function by given the source type
    % , time, location and amlitude paras.
    % 
    % time_s: the occuring time of the source, start and end
    % amp_s: the amplitude of the source
    % type_s: 1--delta function; 2--rampfunction; 3--unistep

    %% find closest t
    loc_t_start = find(abs(time_s0(1)-time) == min(abs(time_s0(1)-time)) );
    time_s(1) = time(loc_t_start);
    loc_t_end = find(abs(time_s0(2)-time) == min(abs(time_s0(2)-time)) );
    time_s(2) = time(loc_t_end);

    %% basic function:
    if type_s == 1
        func = time==time_s(1); 
    elseif type_s == 2
        func = (time-time_s(1))/(time_s(2)-time_s(1)).*(time>=time_s(1) & time<=time_s(2)) ...
            + (time>=time_s(1) & time>time_s(2));
    elseif type_s == 3
        func = time>=time_s(1) & time<=time_s(2);
    end

    %% source time function
    s = amp_s.*func;
    plot(time,s,'b');
    xlabel('time /s')
    ylabel('amplitude');
    title('source time funtion')
    fileformat = ['source_number',num2str(number),'.png'];
    saveas(gcf,fileformat)
    close all
end