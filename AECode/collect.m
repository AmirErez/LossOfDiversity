function alltab = collect(datadir, outfile)
% Collects output in folder and makes table with params and outputs
% datadir = ['..' filesep 'AEData' filesep 'Raw' filesep sim_name];
d = dir([datadir filesep 'out*.mat']);

cnt = 0;
tempstruct = struct;
tempstruct.rho_initial = cell(length(d),1);
tempstruct.rho0 = zeros(length(d),1);
tempstruct.log10c0 = zeros(length(d), 1);
tempstruct.P1 = zeros(length(d),1);
%tempstruct.Pc1 = zeros(length(d),1);
%tempstruct.dist = zeros(length(d),1);
tempstruct.P = cell(length(d),1);
tempstruct.alpha = cell(length(d),1);
tempstruct.rho_ss = cell(length(d),1);
tempstruct.fullname = cell(length(d),1);

tempstruct.ShannonS = NaN*zeros(length(d), 1);
tempstruct.dI = NaN*zeros(length(d), 1); % Difference in nut integrals I1-I2
tempstruct.corrlen_Shannon = NaN*zeros(length(d), 1);
tempstruct.corrlen_err_Shannon = NaN*zeros(length(d), 1);
tempstruct.corrlen_rmse_Shannon = NaN*zeros(length(d), 1);
tempstruct.corrlen_correction_Shannon = NaN*zeros(length(d), 1);
tempstruct.corrlen_dI = NaN*zeros(length(d), 1);
tempstruct.corrlen_err_dI = NaN*zeros(length(d), 1);
tempstruct.corrlen_correction_dI = NaN*zeros(length(d), 1);

tempstruct.K = zeros(length(d),1);
tempstruct.alpha_val = zeros(length(d),1);

for dd=1:length(d)
    fullname = [datadir filesep d(dd).name];
    disp(['Reading ' fullname]);
    if(mod(dd+17,18)==0)
        % figShannon=figure;
        % figdI = figure;
        figShannon=0;
        figdI = 0;
        col='b';
    end
    try
       loaded = load(fullname);
    catch
       warning(['Failed loading ' fullname]);
       continue
    end
    if(~isfield(loaded,'output'))
       warning([ 'No output in file ' fullname ' . Skipping']);
       continue
    end
    params = loaded.params;
    output = loaded.output;
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
    yy=output.ShannonS;
    yy = yy( abs(yy-yy(end)) < max(abs(yy-yy(end))/200) );
    [a,b,c] = shifted_exponential(1:length(yy),yy); % Fits shifted exponential y = a+b*exp(c*x)
    a = real(a);
    b = real(b);
    c = real(c);
    xi_jacqueline = -1/c;
    tempstruct.corrlen_Shannon(cnt) = xi_jacqueline;
    xx = [1:length(yy)]';
    tempstruct.corrlen_rmse_Shannon(cnt) = sqrt(nanmean( (yy-(a+b*exp(c*xx))).^2 ));
    tempstruct.corrlen_correction_Shannon(cnt) = 0;
%     [corr, errcorr, correction, ft, gof, A0, corrected_data] = extract_corr(output.ShannonS',col,figShannon);
%     set(gca,'YScale', 'log')
%     tempstruct.corrlen_Shannon(cnt) = corr;
%     tempstruct.corrlen_err_Shannon(cnt) = errcorr;
%     tempstruct.corrlen_correction_Shannon(cnt) = correction;
    


    tempstruct.dI(cnt) = output.NutIntegrals(2,end)-output.NutIntegrals(1,end);
    yy = abs(output.NutIntegrals(2,:)-output.NutIntegrals(1,:));
    yy = yy( abs(yy-yy(end)) < max(abs(yy-yy(end))/200) );
    [a,b,c] = shifted_exponential(1:length(yy),yy); % Fits shifted exponential y = a+b*exp(c*x)
    xi_jacqueline = -1/c;
    tempstruct.corrlen_dI(cnt) = xi_jacqueline;
    tempstruct.corrlen_err_dI(cnt) = NaN;
    tempstruct.corrlen_correction_dI(cnt) = 0;
%     [corr, errcorr, correction, ft, gof, A0, corrected_data] = extract_corr(abs(output.NutIntegrals(2,:)-output.NutIntegrals(1,:)),col,figdI);
%     set(gca,'YScale', 'log');
%     tempstruct.corrlen_dI(cnt) = corr;
%     tempstruct.corrlen_err_dI(cnt) = errcorr;
%     tempstruct.corrlen_correction_dI(cnt) = correction;

    %tempstruct.Pc1(cnt) = output.Pc1;
    %tempstruct.dist(cnt) = output.dist;
end
alltab = struct2table(tempstruct);
alltab = alltab(1:cnt,:);
%%
disp('--------------------------------------------')
alltab = sortrows(alltab, 'log10c0');
writetable(alltab, outfile);
disp(['Finished collecting to ' outfile]);
disp('--------------------------------------------')
end

