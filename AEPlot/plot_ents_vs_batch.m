%function plot_ents_vs_batch(width, height)


wd = 3.375;
ht = 2.5;

filesdir='../AEData/selected_m_2__c0_1__alpha_0.75';
Pc = 0.706555624235447;
files=dir([filesdir filesep 'out_*.mat']);
%%

newfigure(wd,ht);
hold on
set(gca,'FontSize',18)
set(gca,'Yscale','log')
set(gca,'Xscale','linear')

m = length(files);
% cmap = zeros(m, 3);
% cmap(1,:) = [0.25, 0.3, 0.9];
% dR = 1/(m-1)*0.25;
% dG = 1/(m-1)*0.6;
% dB = -1/(m-1)*0.3;
% for mm=2:m
%     cmap(mm,:) = cmap(mm-1,:)+[dR, dG, dB];
% end
for mm=1:m
    cmap(mm,:) = [0.375, 0.62496, 0.398];
end

ds = zeros(m,1);
for ii = 1:length(files)
    data = load([filesdir filesep files(ii).name]);
    d = Pc - data.params.P(1);
    ds(ii) = d;
    yy = data.output.ShannonS;
    semilogy(yy-yy(end),'-', 'Color', cmap(ii,:), 'LineWidth',2, 'DisplayName', ['$d=' num2str(d,2) '$']);
    hold on
    xx = 1:length(yy);
    fn = find( (abs(yy-yy(end)) < max(abs(yy-yy(end))/400)) & ((abs(yy-yy(end)) < max(abs(yy-yy(end))/1e-5))));
    yy = yy(fn);
    [a,b,c] = shifted_exponential(xx(fn),yy); % Fits shifted exponential y = a+b*exp(c*x)
    a = real(a);
    b = real(b);
    c = real(c);
    xi_jacqueline = -1/c;
    fit_yy = a+b*exp(c*xx);
    semilogy(xx(fn),fit_yy(fn)-a,'--b', 'LineWidth',2); 
end



xl = xlabel('Batch, $b$','Interpreter','latex');
% xl.Position = [2.5e5, 6e-4, -1];
ylabel('$S_{b} - S_{\infty}$','Interpreter','latex')

% annotation('textbox',...
%     [0.25 0.92 0.3 0.08],...
%      'String',{'(a)'},'Interpreter','Latex',...
%      'LineStyle','None','FontSize',18);
 
% xticks([0 5e5])
% xticklabels({'0', '5e5'});
% xlim([0 5e5])
% set(gca,'XScale','log');
ylim(10.^[-5,0]);
yticks(10.^[-5,-3,-1]);

% c = colorbar();
% c.Ticks = linspace(0, 1, 2);
% c.TickLabels={'$10^{-1.5}$', '$10^{-3}$'};
% c.TickLabelInterpreter = 'latex';
% c.Position = [0.6895    0.5167    0.0307    0.3000];
% title(c,'Distance, $d$','Interpreter','latex')

t = text(777,0.0033, '$\sim A e^{-b/\xi} + B$', 'Interpreter','latex','FontSize',17, 'Color','b');

print(gcf,'-dpng', '../AEFigures/fig_entropy_vs_batch.png', '-r600');
print(gcf,'-dsvg', '../AEFigures/fig_entropy_vs_batch.svg');
