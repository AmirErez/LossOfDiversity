% Calculate remapping of 2-species vs. c0. Save and plot.

folder='../AEData/collected/m2_crit_exact';
allfiles = dir([folder filesep 'collected_m_2__c0_*__alpha_0.75__crit_exact.csv']);
files = cell(length(allfiles),1);
alltab = NaN;
for ff=1:length(files)
    files{ff} = [folder filesep allfiles(ff).name];
    tab = readtable(files{ff}, 'Delimiter',',');
    if height(tab) == 0
        continue
    end
    if(ff==1)
        alltab = tab;
    else
        alltab = [alltab; tab];
    end
end
alltab = sortrows(alltab,'log10c0', 'ascend');
log10c0s = unique(alltab.log10c0);

cmap = colormap(brewermap(length(log10c0s),'YlGnBu'));
Pcs = NaN*zeros(length(log10c0s),1);
figcorr_log_noscale=newfigure(4,2);
figure(figcorr_log_noscale);
hold on

for ff=1:length(log10c0s)
    tab = alltab(alltab.log10c0==log10c0s(ff),:);
    c0 = 10.^ log10c0s(ff);
    tab = sortrows(tab,'P1');
    txt = ['$c0=10^{' num2str(c0,2) '}$'];

    [mx,mind] = max(tab.corrlen_Shannon);
    Pcs(ff) = tab.P1(mind);
    P=eval(tab{ff,'P'}{1});
    alpha=eval(tab{ff,'alpha'}{1});
    rho_ss=eval(tab{ff,'rho_ss'}{1});
    I11=P(1)*c0/alpha(1,1)/rho_ss(1);
    I12=P(2)*c0/alpha(1,2)/rho_ss(1);
    
    % 2nd order correction, from Eq. 40 in the eLife 2020 paper
    % Require I1=I2 for remapping boundary for small (or large) c_0/K 
    I1(ff)=I11*(1-( I11*(alpha(1,1)^2)/(2*alpha(1,1)) ...
                +I12*(alpha(1,2)^2)/(alpha(1,1)+alpha(1,2))));
    I2(ff)=I12*(1-( I11*(alpha(1,1)^2)/(alpha(1,1)+alpha(1,2)) ...
                +I12*(alpha(1,2)^2)/(2*alpha(1,2))));
    


   
    plot(Pcs(ff)-tab.P1, tab.corrlen_Shannon,'.', 'Color', cmap(ff,:), 'MarkerSize',11, 'DisplayName', txt);
    set(gca,'YScale','log');
%     set(gcas,'XScale','log');
    xlabel('$d$', 'Interpreter','Latex');
%     xlabel('Nutrient 1 fraction', 'Interpreter','Latex');
    ylabel('$\xi$', 'Interpreter','Latex');
    set(gca,'FontSize',18)
end
% l=legend();
% l.Interpreter='latex';
colormap(cmap);
c=colorbar();
%%
% [s,sind] = sort(log10c0s);
% log10c0s = log10c0s(sind);
% Pcs = Pcs(sind);
figure; 
semilogx(10.^log10c0s, Pcs,'-')
hold on


