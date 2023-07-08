% Plots remapped points
tab=readtable('../AEData/collected/remapped_remap_m2_alphas_c0s.csv');

for ii=1:size(tab,1)
    tab{ii,'alpha'} = {eval(tab{ii,'alpha'}{1})};
    tab{ii,'alpha_val'} = tab{ii,'alpha'}{1}(1,1);
    tab{ii,'rho_ss'} = {eval(tab{ii,'rho_ss'}{1})};
end
tab.d = tab.Pc1-tab.P1;
tab.c0 = 10.^tab.log10c0;
addpath('../AECode/');
%
%% Calculate corrlen at given distance from transition point
d=0.01;
% alpha=0.65;
% ctab = tab(tab.alpha_val==alpha,:);
ctab = tab((tab.log10c0==-2) & (tab.alpha_val==0.75),:);
% log10c0s = unique(tab.log10c0);
corrlen_Shannons = zeros(size(ctab,1),1);
corrlen_rmse_Shannons = zeros(size(ctab,1),1);

parfor cc=1:size(ctab,1)
    disp(['Doing ' num2str(cc) ' of ' num2str(size(ctab,1))]);
    params = struct;
    params.alpha_val = ctab.alpha_val(cc);
    params.p = 2;
    params.m = 2;
    params.K = ctab.K(cc);
    params.rho0 = ctab.rho0(cc);
    params.errtype = 1;
    params.b0 = eval(ctab.rho_initial{cc});
    P1 = ctab.Pc1(cc)-d;
    params.P = [P1, 1-P1]';
    params.E = 1;
    params.max_batches = 1e6;
    params.alpha = ctab.alpha{cc};
    params.log10c0 = ctab.log10c0(cc);
    output = serialdil_odesolver(params,0);

    yy=output.ShannonS;
    % yy = yy( abs(yy-yy(end)) < max(abs(yy-yy(end))/200) );
    yy = yy( abs(yy-yy(end)) < max(abs(yy-yy(end))/50) );
    [a,b,c] = shifted_exponential(1:length(yy),yy); % Fits shifted exponential y = a+b*exp(c*x)
    a = real(a);
    b = real(b);
    c = real(c);
    xi_jacqueline = -1/c;
    output.corrlen_Shannon = xi_jacqueline;
    xx = [1:length(yy)]';
    output.corrlen_rmse_Shannon = sqrt(nanmean( (yy-(a+b*exp(c*xx))).^2 ));
    corrlen_Shannons(cc) = output.corrlen_Shannon;
    corrlen_rmse_Shannons(cc) = output.corrlen_rmse_Shannon;
end
tab.corrlen_Shannon = corrlen_Shannons;
tab.corrlen_rmse_Shannon = corrlen_rmse_Shannons;
tab.d = d*ones(size(corrlen_rmse_Shannons));
% writetable(tab, '../AEData/collected/remapped_remap_m2_alphas_c0s_withcorr.csv')


%% Compare with analytic form. Attricute mismatch at small c0 with difficulty in estimating Pc and also convergence issues for the solver.
tab = readtable('../AEData/collected/remapped_remap_m2_alphas_c0s_withcorr.csv');
for ii=1:size(tab,1)
    % tab{ii,'alpha'} = {eval(tab{ii,'alpha'}{1})};
    % tab{ii,'alpha_val'} = tab{ii,'alpha'}{1}(1,1);
    % tab{ii,'rho_ss'} = {eval(tab{ii,'rho_ss'}{1})};
end
% tab.d = tab.Pc1-tab.P1;
tab.d = 0.01*ones(size(tab,1),1);
tab.c0 = 10.^tab.log10c0;



alphas = unique(tab.alpha_val);
alphas = [0.65,0.75];
width = 3.375;
height = 2.5;
fig = newfigure(width,height);
hold on
% newfigure(2.75,2.75);

m = length(alphas);
pmap = zeros(m, 3);
pmap(1,:) = [0.5, 0.75, 0.25];
dR = 1/(m-1)*0.25;
dG = -1/(m-1)*0.75;
dB = 1/(m-1)*0.75;

% pmap(1,:) = [0, 1, 0.5];
% dR = 0;
% dG = -1/(m-1);
% dB = 1/(m-1)*0.5;

for mm=2:m
    pmap(mm,:) = pmap(mm-1,:)+[dR, dG, dB];
end
% pmap = pmap(end:-1:1,:);
% colors = [[0,100,50];
%           [0,100+dG,50+dB];
%           [0,33,83];
%           [0,0,100]]/100;
% pmap = colormap(copper(length(alpha_vals)));


set(gca,'FontSize', 18);
hold on


for aa=1:length(alphas)
    figure(fig);
    hold on
    if alphas(aa) == 1, continue; end
    ctab = tab(tab.alpha_val==alphas(aa),:);
    % generations = log2(1+ctab.c0./ctab.rho0);
    generations = 1;
    % generations = ctab.c0./(ctab.c0+ctab.rho0);
    loglog(ctab.c0, ctab.corrlen_Shannon.*generations,'-', 'Color', pmap(aa,:), 'DisplayName',['\alpha=' num2str(alphas(aa))], 'LineWidth',2); 
    hold on

    % ylim(10.^[1,2.5])
    
    kgamma1_stars = zeros(size(ctab,1),1);
    kgamma2_stars = zeros(size(ctab,1),1);
    for ii=1:size(ctab,1)
        rho_ss = eval(ctab{ii,'rho_ss'}{1});
        kgamma1_stars(ii) = ctab.alpha_val(ii)*rho_ss(1) + (1-ctab.alpha_val(ii))*rho_ss(2);
        kgamma2_stars(ii) = (1-ctab.alpha_val(ii))*rho_ss(1) + ctab.alpha_val(ii)*rho_ss(2);
    end
    R = ctab.c0./(ctab.c0+ctab.rho0).* ((1-ctab.alpha_val).*ctab.P1./(ctab.alpha_val.^2) - ctab.alpha_val.*(1-ctab.P1)./((1-ctab.alpha_val).^2));
    
    R2 = ctab.c0./(ctab.c0+ctab.rho0).*( (1-ctab.alpha_val).*ctab.Pc1./(ctab.alpha_val.^2) - ctab.alpha_val.*(1-ctab.Pc1)./((1-ctab.alpha_val).^2));
    R3 = ctab.c0./(ctab.c0+ctab.rho0).*(1-2*ctab.alpha_val)./(ctab.alpha_val.*(1-ctab.alpha_val));
    
    theory_xi6 = -1./(ctab.d.*R3);
    theory_xi5 = -1./log(1+(ctab.d.*R3));
    theory_xi4 = -1./log(1+(ctab.d.*R2));
    theory_xi3 = -1./log(1+(ctab.d.*R)) ;
    
    theory_xi2 = -1./ctab.d ./ (   (1-ctab.alpha_val).*ctab.c0.*ctab.P1./(ctab.alpha_val.^2) - ctab.alpha_val.*ctab.c0.*(1-ctab.P1)./((1-ctab.alpha_val).^2)  ) ;
    
    theory_xi1 = -1./(ctab.d.*R);
    Rexact = ctab.c0./(ctab.c0+ctab.rho0).*((1-ctab.alpha_val).*ctab.P1./(kgamma1_stars.^2) - ctab.alpha_val.*(1-ctab.P1)./(kgamma2_stars.^2));
    theory_xi = -1./(ctab.d.*Rexact);
    
    h = loglog(ctab.c0, theory_xi3.*generations, 'o', 'Color', pmap(aa,:), 'MarkerFaceColor', pmap(aa,:), 'MarkerSize', 4);
    hasbehavior(h,'legend',false);
    % % loglog(ctab.c0, theory_xi2.*generations, 'b')
    % loglog(ctab.c0, theory_xi3.*generations, 'g')
    % loglog(ctab.c0, theory_xi4.*generations, '--k')
    h = loglog(ctab.c0, theory_xi6.*generations, 'x', 'Color', pmap(aa,:), 'LineWidth', 2);
    hasbehavior(h,'legend',false);
    set(gca,'YScale','log');
    set(gca,'XScale','log');
    figure(fig)

end
% xlim(10.^[-3, 3]);
% ylim(10.^[1,5]);
% xticks(10.^[-3,0,3])
% yticks(10.^[1,3,5])

xlim(10.^[-2,2])
xticks(10.^[-2,0,2])
ylim(10.^[1,4]);
yticks(10.^[2,4])

xx = 10.^[-2:0.01:2];
h = loglog(xx, 15*(xx+1)./xx,'--b', 'LineWidth',2);
hasbehavior(h,'legend',false);



xl = xlabel('$c_0/K$', 'Interpreter','latex');
yl = ylabel('$\xi$', 'Interpreter','latex');
legend('show')
tt=text(0.0147, 23.3533, '$\xi \sim \frac{c_0+\rho_0}{c_0}$', 'Interpreter','latex', 'FontSize',17, 'Color', 'b');

print(gcf,'../AEFigures/fig_generation_vs_c0', '-dsvg')
print(gcf,'../AEFigures/fig_generation_vs_c0', '-dpng', '-r600')

%%
earlybird_fig = newfigure(width,height);
set(gca,'FontSize', 18);
hold on
for aa=1:length(alphas)
    ctab = tab(tab.alpha_val==alphas(aa),:);
    R = ctab.c0./(ctab.c0+ctab.rho0).* ((1-ctab.alpha_val).*ctab.P1./(ctab.alpha_val.^2) - ctab.alpha_val.*(1-ctab.P1)./((1-ctab.alpha_val).^2));
    theory_xi3 = -1./log(1+(ctab.d.*R)) ;
    loglog(ctab.c0, ctab.corrlen_Shannon./theory_xi3, '.-', 'Color', pmap(aa,:), 'DisplayName',['\alpha=' num2str(alphas(aa))], 'LineWidth', 2);
end
set(gca,'XScale', 'log')
set(gca,'YScale', 'log')
xl = xlabel('$c_0/K$', 'Interpreter','latex');
yl = ylabel('$\xi/\xi_{chem}$', 'Interpreter','latex');
l = legend('show');
l.Position = [ 0.5280    0.7439    0.3868    0.2472];
xlim(10.^[-2,2]);
xticks(10.^[-2,0,2]);
ylim([0.7,1.3]);
yticks([0.7,1,1.3]);
print(gcf,'../AEFigures/fig_earlybird', '-dsvg')
print(gcf,'../AEFigures/fig_earlybird', '-dpng', '-r600')