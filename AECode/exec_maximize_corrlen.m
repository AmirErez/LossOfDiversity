function exec_maximize_corrlen(datadir, max_runs)
    % Saves next available out_0001 file
    rng('shuffle');

    x=load([datadir filesep 'params.mat']);
    params = x.params;
%    maximize_corrlen(params,max_runs,datadir, params.alpha_val+0.2*2*(rand()-1));
%    maximize_corrlen(params,max_runs,datadir, 1-rand()/2);
    maximize_corrlen(params,max_runs,datadir, params.alpha_val-0.09*rand());

end
