function make_split_using_remap_twospecies(sim_name)
% Makes split using the remapping information to get logarithmically slow
% to the transition point

%Determine the values of the running parameters
%log10c0s = [3:-0.25:-3]; %Start from large c0s first, they are faster.
log10c0s = [2 0 -2]; %Start from large c0s first, they are faster.
distances = 10.^[-1:-0.1:-4]';
distances = [distances; -distances];

datadir = ['..' filesep 'Data' filesep 'Raw' filesep sim_name filesep];
remapfile = [datadir 'remapped_' sim_name '.csv'];
outtab = [datadir 'to_run.csv'];
outparams = [datadir 'params.mat'];
try
    remaptab = readtable(remapfile);
catch
    error(['Could not load ' remapfile])
end

try
    paramfile = [datadir 'remapping_params.mat'];
    load(paramfile);
catch
    error(['Could not load ' paramfile]);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('-------------------------------------------------------------');

save(outparams,'params');
for ii=1:height(remaptab)
    remaptab{ii,'alpha'} = {eval(remaptab{ii,'alpha'}{1})};
    remaptab{ii,'alpha_val'} = remaptab{ii,'alpha'}{1}(1,1);
end
%alpha_vals = unique(remaptab.alpha_val);
alpha_vals = 0.75;


%Make the table with the running parameters
totlen = length(log10c0s)*length(distances)*length(alpha_vals);
tempstruct = struct;
tempstruct.num = zeros(totlen, 1);
tempstruct.log10c0s = zeros(totlen, 1);
tempstruct.p_str = cell(totlen, 1);
tempstruct.alpha_str = cell(totlen, 1);
tempstruct.Pc1 = zeros(totlen, 1);
tempstruct.dist = zeros(totlen, 1);
tempstruct.filename = cell(totlen, 1);

cnt = 0;
for c=1:length(log10c0s)
    log10c0 = log10c0s(c);
    c0tab = remaptab(remaptab.log10c0 == log10c0, :);
    for aa=1:length(alpha_vals)
        alphac0tab = c0tab(c0tab.alpha_val==alpha_vals(aa),:);
        if(height(alphac0tab)~=1)
            disp(['Warning. Wrong size of table. log10c0 ' num2str(log10c0) ' ; alpha ' num2str(alpha_vals(aa))]);
            continue;
        end
        Pc1=alphac0tab.Pc1;
        for dd=1:length(distances)
            dist = distances(dd);
            p1 = Pc1+dist;
            if(p1>1), continue; end
            cnt = cnt+1;

            %Put values inside a structure
            tempstruct.num(cnt) = cnt;
            tempstruct.log10c0s(cnt) = log10c0;
            tempstruct.p_str{cnt} = mat2str([p1 1-p1]);
            tempstruct.alpha_str{cnt} = mat2str(alphac0tab.alpha{1});
            tempstruct.Pc1(cnt) = Pc1;
            tempstruct.dist(cnt) = dist;
            tempstruct.filename{cnt} = ['out_' sprintf('%.4d', cnt)];
        end
    end
end
alltab = struct2table(tempstruct);
alltab = alltab(1:cnt, :);
disp(['Saving to ' outtab]);
writetable(alltab, outtab);

disp('=============================================================');
disp('Done');
disp('=============================================================');

