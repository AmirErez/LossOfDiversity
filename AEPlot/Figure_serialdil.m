%This script generates serial dilutions figure
clear;clc;
inside = load('insidebatch.mat');
inside = inside.Bstorage; 
% newfigure(3.42,2);
width = 3.375;
height = 2.5;
newfigure(width,height)

%Set up master axis
masterax = axes('Position',[0 0 1 1]);
xlim([0 1])
ylim([0 1])
axis off
hold on
batchx = [0.06 0.4 0.74]+0.013;
% batchx = [0.09 0.45 0.77];
batchy = 0.18;
batchw = 0.2;
batchh = 0.27;

for i = 1:3
    rectangle('Position',[batchx(i)-0.04, batchy - 0.1, batchw+0.08, batchh+0.2],'Curvature',0.2,'LineWidth',1)
    annotation('textarrow',[batchx(i)+batchw/2, batchx(i)+batchw/2],[batchy+0.55, batchy+batchh+0.1],'String','$c_0$','Interpreter','latex','FontSize',18)
end
circular_arrow(gcf,0.1,[mean(batchx(1:2))+0.1,batchy+batchh+0.08],90,150,1)
% text(mean(batchx(1:2)),batchy+batchh+0.3,'$\times \frac{n_0}{\sum n_{\sigma}}$','Interpreter','latex','FontSize',15);
text(mean(batchx(1:2))*1.02,batchy+batchh+0.25,'Dilute','Interpreter','latex','FontSize',18);
circular_arrow(gcf,0.1,[mean(batchx(2:3))+0.1,batchy+batchh+0.08],90,150,1)
% text(mean(batchx(2:3)),batchy+batchh+0.3,'$\times \frac{n_0}{\sum n_{\sigma}}$','Interpreter','latex','FontSize',15);
text(mean(batchx(2:3))*1.02,batchy+batchh+0.25,'Dilute','Interpreter','latex','FontSize',18);

% text(0.03,0.84,'(a)','FontSize',18,'Interpreter','latex');

m = 4;
%colors = jet(m);
% colors = hot(140);
% colors = colors([1,33,66,100],:);
colors = [[0,100,50];
          [0,66,66];
          [0,33,83];
          [0,0,100]]/100;

for i = 1:3
    batchax(i) = axes('Position',[batchx(i)+0.01 batchy+0.04 batchw batchh]);
    xticks([])
    yticks([])
    xlabel('$t$','Interpreter','latex','FontSize',18);
    yl = ylabel('$\rho_\sigma$','Interpreter','latex','FontSize',18);
    yl.Position = [yl.Position(1)+2 yl.Position(2)+0.5 yl.Position(3)]';
    if i == 1
        tstore = inside.time1;
        Bstore = inside.batch1;
    elseif i == 2
        tstore = inside.time2;
        Bstore = inside.batch2;
    else
        tstore = inside.time3;
        Bstore = inside.batch3;
    end
  
    for j=1:m
        hold on
        plot(tstore,Bstore(j,:),'Color',colors(j,:),'LineWidth',2)
        
    end
    xlim([0,tstore(end)])
    ylim([0,1])
end


print(gcf,'-dpng','../AEFigures/Fig_serialdil','-r600')
print(gcf,'-dsvg','../AEFigures/Fig_serialdil')


