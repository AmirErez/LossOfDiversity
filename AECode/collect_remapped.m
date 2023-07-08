function collect(sim_name)
% Collect remapped files.
% Collects output in folder and makes table with params and outputs
datadir = ['..' filesep 'Data' filesep 'Raw' filesep sim_name];
d = dir([datadir filesep 'remap_*.mat']);

cnt = 0;
tempstruct = struct;
tempstruct.rho_initial = cell(length(d),1);
tempstruct.rho0 = zeros(length(d),1);
tempstruct.log10c0 = zeros(length(d), 1);
tempstruct.P1 = zeros(length(d),1);
tempstruct.P = cell(length(d),1);
tempstruct.Pc = cell(length(d),1);  % Remapped point
tempstruct.Pc1 = zeros(length(d),1);  % Remapped point
tempstruct.alpha = cell(length(d),1);
tempstruct.rho_ss = cell(length(d),1);
tempstruct.fullname = cell(length(d),1);
tempstruct.ShannonS = zeros(length(d), 1);
tempstruct.corrlen = zeros(length(d), 1);
tempstruct.corrlen_err = zeros(length(d), 1);
tempstruct.corrlen_correction = zeros(length(d), 1);
tempstruct.K = zeros(length(d),1);
tempstruct.alpha_val = zeros(length(d),1);


for dd=1:length(d)
    fullname = [sim_name filesep d(dd).name];
    fullpath = ['..' filesep 'Data' filesep 'Raw' filesep fullname];
    disp(['Reading ' fullname]);
    try
       load(fullpath);
    catch
       warning(['Failed loading ' fullname]);
       continue
    end
    cnt = cnt+1;
    tempstruct.rho_initial{cnt} = mat2str(params.b0);
    tempstruct.log10c0(cnt) = params.log10c0;
    tempstruct.P1(cnt) = params.P(1);
    tempstruct.P{cnt} = mat2str(params.P);
    tempstruct.alpha{cnt} = mat2str(params.alpha);
    tempstruct.K(cnt) = params.K;
    tempstruct.rho0(cnt) = params.rho0;
    tempstruct.alpha_val(cnt) = params.alpha_val;
    tempstruct.fullname{cnt} = fullname;

    tempstruct.rho_ss{cnt} = mat2str(output.rho(:,end));
    tempstruct.ShannonS(cnt) = output.ShannonS(end);
    tempstruct.corrlen(cnt) = output.corrlen;
    tempstruct.corrlen_err(cnt) = output.corrlen_err;
    tempstruct.corrlen_correction(cnt) = output.corrlen_correction;
    tempstruct.Pc{cnt} = mat2str(remapped_P);
    tempstruct.Pc1(cnt) = remapped_P(1);

end
alltab = struct2table(tempstruct);
alltab = alltab(1:cnt,:);
%%
disp('--------------------------------------------')
outfile1 = [datadir filesep 'remapped_' sim_name '.csv' ];
writetable(sortrows(alltab, 'log10c0'), outfile1);
disp(['Finished collecting to ' datadir]);
disp('--------------------------------------------')
end

