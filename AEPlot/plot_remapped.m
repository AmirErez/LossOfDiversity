% Plots remapped points
tab=readtable('../AEData/collected/remapped_remap_m2_alphas_c0s.csv');

for ii=1:size(tab,1)
    tab{ii,'alpha'} = {eval(tab{ii,'alpha'}{1})};
    tab{ii,'alpha_val'} = tab{ii,'alpha'}{1}(1,1);
end
tab.c0 = 10.^tab.log10c0;
%%

figure;
alpha_vals = unique(tab.alpha_val);
% pmap = colormap(hot(length(alpha_vals)+4));
pmap = colormap(copper(length(alpha_vals)));
maxdiffs = zeros(length(alpha_vals),1);
for pp=1:length(alpha_vals)
    ctab = tab(tab.alpha_val==alpha_vals(pp),:);
    ctab.c0 = 10.^ctab.log10c0;
%     ctab.monod_c0 = ctab.c0./(ctab.c0+ctab.K);
    [mn, mind] = min(ctab.Pc1);
    maxdiffs(pp) = alpha_vals(pp)-mn;
    shifted_c0 = ctab.c0/ctab.c0(mind);
    semilogx(ctab.c0, ctab.Pc1,'-', 'Color', pmap(pp,:), 'LineWidth',2)
    hold on
%     semilogx(ctab.c0(mind), mn,'o','Color', pmap(pp,:));
%     semilogx(shifted_c0, ctab.Pc1./ctab.alpha_val,'-', 'Color', pmap(pp,:), 'LineWidth',2)

end

%%

figure;
alpha_vals = unique(tab.alpha_val);
pmap = copper(length(alpha_vals));
for pp=1:length(alpha_vals)
    ctab = tab(tab.alpha_val==alpha_vals(pp),:);
    ctab.c0 = 10.^ctab.log10c0;
    ctab.monod_c0 = ctab.c0./(ctab.c0+ctab.K);
    loglog(ctab.c0, ctab.corrlen.*log2((10.^ctab.log10c0+ctab.rho0)./ctab.rho0),'.-', 'Color', pmap(pp,:))
    hold on
end

%%

figure;
alpha_vals = unique(tab.alpha_val);
pmap = copper(length(alpha_vals));
for pp=1:length(alpha_vals)
    ctab = tab(tab.alpha_val==alpha_vals(pp),:);
    loglog(10.^ctab.log10c0, ctab.ShannonS,'.-', 'Color', pmap(pp,:))
    hold on
end
