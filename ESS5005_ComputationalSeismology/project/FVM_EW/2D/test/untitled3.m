CoreNum = 2;        % number of cores to be called
if isempty(gcp('nocreate'))
    p = parpool(CoreNum);
end

for i = 1:10
    parfor j = 1:3
        j
    end
end

delete(p)