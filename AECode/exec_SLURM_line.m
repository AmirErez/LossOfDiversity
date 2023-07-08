function exec_SLURM_line(dir,linenum_str)
   linenum = str2num(linenum_str)
   tab = readtable([dir filesep 'to_run.csv'], 'Delimiter', ',');
   load([dir filesep 'params.mat']);
   params.log10c0 = tab.log10c0s(linenum);
   params.P = eval(tab.p_str{linenum});
   params.P = params.P';
   params.alpha = eval(tab.alpha_str{linenum});
   filename=tab.filename{linenum};
   disp('A serial dilution simulation is starting...');
   params
   disp ('P = ')
   params.P
   disp('alpha = ')
   params.alpha
   output = exec_serialdil(params);
   outfile = [dir filesep filename '.mat'];
   disp(['Saving to ' outfile])
   save(outfile, 'params', 'output');
   disp('------------------------------------------------------')
   disp(['Finished! Saved to ' outfile]);
end
