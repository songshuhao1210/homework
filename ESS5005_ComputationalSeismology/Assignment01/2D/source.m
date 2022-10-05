function [s] = source(time_s0,amp_s,time,type_s,number,extra_inf)
    % SOURCE.m generate the source time function by given the source type
    % , time, location and amlitude paras.
    % 
    % time_s: the occuring time of the source, start and end
    % amp_s: the amplitude of the source
    % type_s: 1--delta function; 2--unistep; 3--single frequency
    % number: the number of this source

    %% find closest t
    loc_t(1) = find(abs(time_s0(1)-time) == min(abs(time_s0(1)-time)) );
    time_s(1) = time(loc_t(1));
    loc_t(2) = find(abs(time_s0(2)-time) == min(abs(time_s0(2)-time)) );
    time_s(2) = time(loc_t(2));

    %% basic function:
    if type_s == 1
        func = time==time_s(1); 
    elseif type_s == 2
        func = time>=time_s(1) & time<=time_s(2);
    elseif type_s == 3
        func = GivenSource(time(1:loc_t(2)-loc_t(1)+1),loc_t,extra_inf);
    else
        disp("wrong source type")
    end

    %% source time function
    s = amp_s(1).*func;
    plot(time,s,'b');
    xlabel('time /s')
    ylabel('amplitude');
    title('source time funtion')
    fileformat = ['source_number',num2str(number),'.png'];
    saveas(gcf,fileformat)
    close all
end