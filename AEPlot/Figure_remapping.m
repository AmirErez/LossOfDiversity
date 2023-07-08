% Plots remapped points
tab=readtable('../AEData/collected/remapped_remap_m2_alphas_c0s.csv');

for ii=1:size(tab,1)
    tab{ii,'alpha'} = {eval(tab{ii,'alpha'}{1})};
    tab{ii,'alpha_val'} = tab{ii,'alpha'}{1}(1,1);
end
tab.c0 = 10.^tab.log10c0;
%

wd = 3.375;
ht = 2.5;
newfigure(wd,ht)
hold on
% newfigure(2.75,2.75);

m = 8;
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

alpha_vals = unique(tab.alpha_val);
alpha_vals = alpha_vals(1:end);
maxdiffs = zeros(length(alpha_vals),1);
for pp=1:length(alpha_vals)
    ctab = tab(tab.alpha_val==alpha_vals(pp),:);
    [mn, mind] = min(ctab.Pc1);
    maxdiffs(pp) = alpha_vals(pp)-mn;
    shifted_c0 = ctab.c0/ctab.c0(mind);
    semilogx(ctab.c0, ctab.Pc1,'-', 'Color', pmap(pp,:), 'LineWidth',2)
    hold on
    if(alpha_vals(pp) == 0.75)
        ctab = ctab(ctab.log10c0==1, :);
        semilogx(ctab.c0, ctab.Pc1,'o', 'Color', pmap(pp,:), 'LineWidth',2)
    end
end
ax = gca;
ax.XScale = 'log';
ax.XTick = [1e-3 1 1e3];
xlabel('Nutrient load, $c_0/K$', 'Interpreter','latex');
ylabel('Transition, $P_c$', 'Interpreter','latex');
ylim([0.6,1]);
yticks([0.6:0.2:1]);
% text(2e-5,0.49,'(d)','FontSize',18,'Interpreter','latex');

colormap(pmap)
c = colorbar();
%c.Position = [ 0.7572    0.3533    0.0291    0.1800];
set(c,'Fontsize', 18);
c.Ticks = [0 1];
c.TickLabels = [min(tab.alpha_val) max(tab.alpha_val)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$\alpha$','Interpreter','latex');
t.Position = [32   52     0];
print(gcf,'../AEFigures/Fig_transition', '-dsvg')
print(gcf,'../AEFigures/Fig_transition', '-dpng', '-r600')