function make_split_remap
% Makes a split for finding the remapping for the params.

%%
%sim_name = 'remap_m2_alphas_c0s_exact';
%sim_name='remap_m2_alphas_c0s_try2';
%sim_name='remap_m2_alphas_c0s_try3';
sim_name='remap_m2_alphas_c0s_try4';

%Determine the values of the running parameters
log10c0s = [2 0 -2]; %Start from large c0s first, they are faster.
alpha_vals = [0.75];

%Define a default structure of parameters
%General parameters
params.alpha_val = 1;
params.p = 2;
params.m = 2;
params.K  = 1;
params.rho0 = 1;
params.errtype=1; % 1 for abundance. 0 for diversity.
params.b0 = zeros(params.m,1) + params.rho0/params.m; 
%Moving parameters
params.log10c0 = 0;
params.P = zeros(params.p,1) + 1/params.p; 
params.E = 1;
%Guiding parameters
params.max_batches = 3e6;

%alpha - strategy matrix
ints = linspace(params.alpha_val, 1-params.alpha_val,params.m);
params.alpha = zeros(params.m,2);
for j =1:params.m
    params.alpha(j,1) = ints(j);
    params.alpha(j,2) = 1 - ints(j);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('-------------------------------------------------------------');
outdir = ['..' filesep 'Data' filesep 'Raw' filesep sim_name];
outparams = [outdir filesep 'remapping_params.mat'];
outtab = [outdir filesep 'remap_to_run.csv'];

if (~exist(outdir,'dir')), mkdir(outdir); end
save(outparams,'params');



%Make the table with the running parameters
tempstruct = struct;
tempstruct.num = zeros(length(log10c0s)*length(alpha_vals), 1);
tempstruct.log10c0s = zeros(length(log10c0s)*length(alpha_vals), 1);
tempstruct.alpha_val = zeros(length(log10c0s)*length(alpha_vals), 1);
tempstruct.p_str = cell(length(log10c0s)*length(alpha_vals), 1);
tempstruct.s_str = cell(length(log10c0s)*length(alpha_vals), 1);
tempstruct.filename = cell(length(log10c0s)*length(alpha_vals), 1);

cnt = 0;
for c=1:length(log10c0s)
    log10c0 = log10c0s(c);
    for aa=1:length(alpha_vals)
        params.alpha_val = alpha_vals(aa);
        cnt = cnt+1;

        %alpha - strategy matrix
        ints = linspace(params.alpha_val, 1-params.alpha_val,params.m);
        params.alpha = zeros(params.m,2);
        for j =1:params.m
            params.alpha(j,1) = ints(j);
            params.alpha(j,2) = 1 - ints(j);
        end

        %Put values inside a structure
        tempstruct.num(cnt) = cnt;
	tempstruct.alpha_val(cnt) = params.alpha_val;
        tempstruct.log10c0s(cnt) = log10c0;
        tempstruct.p_str{cnt} = mat2str([0.51 0.49]);
        tempstruct.s_str{cnt} = mat2str(params.alpha);
        tempstruct.filename{cnt} = ['remap_' sprintf('%.3d', cnt)];
    end
end
alltab = struct2table(tempstruct);
disp(['Saving to ' outtab]);
writetable(alltab, outtab);

disp('=============================================================');
disp('Done');
disp('=============================================================');

