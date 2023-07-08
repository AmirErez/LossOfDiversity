% Plots remapped points
% tab = readtable('../AEData/collected/collected_remap_m2_alphas_c0s_exact.csv');
%tab = readtable('../AEData/collected/collected_remap_m2_alphas_c0s_try2.csv');
tab = readtable('../AEData/collected/collected_remap_m2_alphas_c0s_try3.csv');


for ii=1:height(tab)
    tab{ii,'alpha'} = {eval(tab{ii,'alpha'}{1})};
    tab{ii,'alpha_val'} = tab{ii,'alpha'}{1}(1,1);
end
%%
tab = sortrows(tab, 'P1');
alpha_vals = unique(tab.alpha_val);
pmap = colormap(hot(length(alpha_vals)+4));
log10c0s = unique(tab.log10c0);
for cc=1:1%length(log10c0s)
    log10c0 = log10c0s(cc);
    c0tab = tab(tab.log10c0==log10c0,:);
    figure;

    for pp=1:length(alpha_vals)
        ctab = c0tab(c0tab.alpha_val==alpha_vals(pp),:);
        errorbar(-(ctab.dist-0.0008), ctab.corrlen_Shannon,ctab.corrlen_err_Shannon,'+-', 'Color', pmap(pp,:), 'LineWidth',2)
%         plot(ctab.Pc1-ctab.P1, ctab.dist,'.-', 'Color', pmap(pp,:), 'LineWidth',2, 'DisplayName', num2str(alpha_vals(pp)))
        hold on
        title(10^log10c0);
    end
end
set(gca,'XScale','log')
set(gca,'YScale','log')

figure; plot(ctab.dist+ 0.001, ctab.ShannonS,'+k', 'LineWidth',2)
