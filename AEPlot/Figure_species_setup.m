fig3 = newfigure(3.42,3.42);

[fig1ax,pos] = tight_subplot(3,1,0.01,0.01,0.01);
addpath('alchemyst-ternplot');

P = [0.3 0.7];

ms = [2,8,32];
alpha_val=0.75;

for mm=1:length(ms)

    ints = linspace(alpha_val, 1-alpha_val,ms(mm));
    alpha = zeros(ms(mm),2);
    for j =1:ms(mm)
        alpha(j,1) = ints(j);
        alpha(j,2) = 1 - ints(j);
    end

    axes(fig1ax(mm));
    dotplotx = 0.53;
    diamondplotx = 0.5;
    plot(linspace(0,1,100),repmat(0.5,100),'-','LineWidth',2,...
        'Color','k')
    hold on
    %colors = jet(4);
    colors = hot(ms(mm)+2);
%     colors = colors([1,33,66,100],:);
    for i = 1:ms(mm)
        plot([alpha(i,1), alpha(i,1)],[0.5,dotplotx],'k-')
        plot(alpha(i,1),dotplotx,'o','MarkerFaceColor',colors(i+2,:), 'MarkerEdgeColor','k','MarkerSize',4)
    end

    plot([P(1), P(1)],[diamondplotx,diamondplotx+0.1],'k-', 'LineWidth', 1)
    plot(P(1),diamondplotx+0.1,'d','MarkerFaceColor','k', 'MarkerEdgeColor','k','MarkerSize',4);
    xlim([0, 1]);
    ylim([0.3,0.7]);
%     text(-0.02,0.3 + 0.4*0.85,'(b)','FontSize',18,'Interpreter','latex');
    axis off
end

print(gcf,'../AEFigures/Fig_changing_m', '-dpng', '-r300');
print(gcf,'../AEFigures/Fig_changing_m', '-dsvg');

