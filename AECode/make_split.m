function make_split
%%

%ms = [2,3,6,10,32,64,101,320,640,1001];
%ms = [2,4,8,16,32,64,128,256,512,1024];

ms = 2.^[1:10];
%ms = [2, 1+2.^[1:10]];

for mm=1:length(ms)
   log10c0 = 2;
   %alpha_val=0.75;
   %p1s = [0.5:0.005:0.65 0.6505:0.0005:0.7 0.7002:0.0001:0.8 0.8005:0.0005:0.85 0.855:0.005:1];

   %alpha_val=0.9;
   %p1s = [0.75:0.001:0.8 0.8001:0.0005:0.82 0.8201:0.0001:0.9];

   alpha_val=1;
   p1s = [0.85:0.001:0.9 0.9001:0.0005:0.93 0.9301:0.0001:0.975 0.975025:0.000025:1];

   sim_name = ['m_' num2str(ms(mm)) '__c0_' num2str(log10c0) '__alpha_' num2str(alpha_val)];
   sim_name = [sim_name '__grid_full']
   outdir = ['..' filesep 'AEData' filesep 'Raw' filesep sim_name];
   make_split_fun(ms(mm), log10c0, alpha_val, outdir, p1s);
end

function make_split_fun(m, log10c0, alpha_val, outdir, p1s)
   params.m = m;
   params.alpha_val = alpha_val;
   params.log10c0 = log10c0;

   %Determine the values of the running parameters
%   p1s = linspace(1,0.5,101);
%   p1s = linspace(1,0.5,251);

   %Define a default structure of parameters
   %General parameters
   params.p = 2;
   params.K  = 1;
   params.rho0 = 1;
   params.errtype=1; % 1 for abundance. 0 for diversity.
   params.b0 = zeros(params.m,1) + params.rho0/params.m;
   %Moving parameters
   params.P = zeros(params.p,1) + 1/params.p;
   params.E = 1;
   %Guiding parameters
   params.max_batches = 1e6;

   %s - strategy matrix
   ints = linspace(params.alpha_val, 1-params.alpha_val,params.m);
   params.alpha = zeros(params.m,2);
   for j =1:params.m
      params.alpha(j,1) = ints(j);
      params.alpha(j,2) = 1 - ints(j);
   end

   disp('-------------------------------------------------------------');
   outparams = [outdir filesep 'params.mat'];
   outtab = [outdir filesep 'to_run.csv'];

   if (~exist(outdir,'dir')), mkdir(outdir); end
   save(outparams,'params');

   %Make the table with the running parameters
   tempstruct = struct;
   tempstruct.num = zeros(length(p1s), 1);
   tempstruct.log10c0s = zeros(length(p1s), 1);
   tempstruct.p_str = cell(length(p1s), 1);
   tempstruct.alpha_str = cell(length(p1s), 1);
   tempstruct.filename = cell(length(p1s), 1);

   cnt = 0;
   for p=1:length(p1s)
        p1 = p1s(p);
        cnt = cnt+1;

        %Put values inside a structure
        tempstruct.num(cnt) = cnt;
        tempstruct.log10c0s(cnt) = log10c0;
        tempstruct.p_str{cnt} = mat2str([p1 1-p1]);
        tempstruct.alpha_str{cnt} = mat2str(params.alpha);
        tempstruct.filename{cnt} = ['out_' sprintf('%.4d', cnt)];
   end
   alltab = struct2table(tempstruct);
   disp(['Saving to ' outtab]);
   writetable(alltab, outtab);

   disp('=============================================================');
   disp('Done');
   disp('=============================================================');
end
end
