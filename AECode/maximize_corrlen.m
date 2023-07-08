function maxcorr_out = maximize_corrlen(params, max_runs, dirname, initial_P1)
    maxcorr_out = struct;
    maxcorr_out.cnt = zeros(length(max_runs),1);
    maxcorr_out.P = cell(length(max_runs),1);
    maxcorr_out.P1 = zeros(length(max_runs),1);
    maxcorr_out.filename = cell(length(max_runs),1);
    maxcorr_out.corrlen_Shannon = zeros(length(max_runs), 1);
    maxcorr_out.ShannonS = zeros(length(max_runs), 1);
    maxcorr_out.dI = zeros(length(max_runs), 1);

    rng('shuffle');
    cnt = 0;
    prev_P1 = NaN;
    P1 = initial_P1;
    prev_corr = 0;
    maxcorr_out.accepted=0;
    maxcorr_out.rejected=0;
    while cnt<max_runs
        params.P = [P1; 1-P1];
        tic;
        output = exec_serialdil(params);
        toc;
        outfile = [dirname filesep nextname([dirname filesep 'out_'], '0001','.mat')];
        save(outfile, 'params','output');
        disp(['Saved ' outfile])
        cnt=cnt+1;
        %outfile = [dirname filesep sprintf('maxcorr_%.4d.mat',cnt)];
        maxcorr_out.filename{cnt} = outfile;
        maxcorr_out.P{cnt} = params.P;
        maxcorr_out.P1(cnt) = P1;
        maxcorr_out.corrlen_Shannon(cnt) = output.corrlen;
        maxcorr_out.ShannonS(cnt) = output.ShannonS(end);
        maxcorr_out.dI(cnt) = output.NutIntegrals(2,end)-output.NutIntegrals(1,end);

        corrs(cnt) = output.corrlen;
        prob=exp(20*(output.corrlen-prev_corr)/output.corrlen);
        if(prob>rand())
            maxcorr_out.accepted = maxcorr_out.accepted+1;
            disp([num2str(cnt) '  Accept Corr ' num2str(output.corrlen) ' prob ' num2str(prob,3) ...
                ' ; P1 ' num2str(P1) ' ; Acceptfrac ' num2str(maxcorr_out.accepted/(maxcorr_out.accepted+maxcorr_out.rejected),3)]);          
            prev_P1 = P1;
            prev_corr = output.corrlen;
            P1 = P1 + randn()/300;
        else
            maxcorr_out.rejected = maxcorr_out.rejected+1;
            disp([num2str(cnt) '  Rejected Corr ' num2str(output.corrlen) ' prob ' num2str(prob,3) ...
                ' ; P1 ' num2str(P1) ' ; Acceptfrac ' num2str(maxcorr_out.accepted/(maxcorr_out.accepted+maxcorr_out.rejected),3)]);
            P1 = prev_P1 + randn()/300;
        end
        % save([dirname filesep 'temp_maximize_corrlen.mat'], 'maxcorr_out')
    end
end

