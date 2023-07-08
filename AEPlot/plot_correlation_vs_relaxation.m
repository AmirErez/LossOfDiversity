
load('../AEData/RandProcess/Table_rand.mat');
width = 3.375;
height = 2.5;
newfigure(width,height)
cmap = colormap(winter(2*length(T.corrlen)));
n=length(cmap);
hold on

for i = 1:length(T.corrlen)
    plot(T.corrlen(i),T.corrd(i),'.','color',cmap(n-i-floor(n/2)+1,:),'MarkerSize',20)
    
end
lim = 400:3000;
plot(lim,lim)

xlim([lim(1) lim(end)]);
ylim([lim(1) lim(end)]);
set(gca,'Xscale','log')
set(gca,'Yscale','log')
xlabel('Correlation', 'Interpreter','latex');
ylabel('Relaxation', 'Interpreter','latex');

% annotation('textbox',...
%     [0.8 0.25 0.3 0.08],...
%      'String',{'(b)'},'Interpreter','Latex',...
%      'LineStyle','None','FontSize',18);
 
 
set(gca,'xtick',[lim(1) lim(end)])
set(gca,'ytick',[lim(1) lim(end)])
set(gca,'FontSize',18)


c = colorbar();
c.Ticks = linspace(0, 1, 2);
c.TickLabels = {'$10^{-1}$', '$10^{-3}$'};
c.Position = [0.48 0.55 0.037 0.3];
c.TickLabelInterpreter = 'latex';
title(c,'Distance, $d$','Interpreter','latex')

print(gcf,'-dpng', '../AEFigures/fig_correlation_vs_relaxation.png', '-r600');
print(gcf,'-dsvg', '../AEFigures/fig_correlation_vs_relaxation.svg');
