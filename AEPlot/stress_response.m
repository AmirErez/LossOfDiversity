
%% Calculate corrlen at given distance from transition point

params.alpha_val = 0.75;
params.p = 2;
params.m = 11;
params.K = 1;
params.rho0 = 1;
params.errtype = 1;
P1i = params.alpha_val-0.15;
P1s = params.alpha_val+0.01;
P1f = P1i;
params.E = 1;
params.max_batches = 1e6;


ints = linspace(params.alpha_val, 1-params.alpha_val,params.m);
   params.alpha = zeros(params.m,2);
   for j =1:params.m
      params.alpha(j,1) = ints(j);
      params.alpha(j,2) = 1 - ints(j);
   end
params.log10c0 = 1;
mmap = colormap(copper(params.m));

params_i = params;
params_i.b0 = (1/params.m)*ones(params.m, 1);
params_i.P = [P1i, 1-P1i]';
output_i = serialdil_odesolver(params_i,1);

params_s = params;
params_s.P = [P1s, 1-P1s]';
params_s.b0 = output_i.rho(:,end)/params.rho0;
output_s = serialdil_odesolver(params_s,1);


params_f = params;
params_f.P = [P1f, 1-P1f]';
params_f.b0 = output_s.rho(:,10)/params_s.rho0;
output_f = serialdil_odesolver(params_f,1);

%%


rho_i = output_i.rho(:,(end-19:end))'/params_i.rho0;
t_i=1:20;
P_i=ones(1,20)*params_i.P(1);
rho_s = [output_i.rho(:,end), output_s.rho(:,1:10) ]'/params_s.rho0;
t_s = 20:30;
P_s=[params_i.P(1),ones(1,10)*params_s.P(1)];
rho_f = [output_s.rho(:,10), output_f.rho(:,1:60) ]'/params_f.rho0;
t_f=30:90;
P_f = [params_s.P(1), ones(1,60)*params_f.P(1)];

ts = [t_i,t_s,t_f];
rhos = [rho_i; rho_s; rho_f]';
mes = exp(-sum(rhos.*log(rhos),1));
Ps = [P_i, P_s, P_f];

fig=newfigure(3,2); 
set(gca,'FontSize',12);
hold on;
for mm=1:params.m
    plot(ts,rhos(mm,:), '-','Color', mmap(mm,:), 'LineWidth',2);
    % plot(1:20,rho_i(mm,:), '-','Color', mmap(mm,:));
    % plot(20:30, rho_s(mm,:), '-','Color', mmap(mm,:));
    % plot(30:70, rho_f, '-','Color', mmap(mm,:));
end
set(gca,'YScale','log');
ylabel('Abundance, $\rho_\sigma$','Interpreter','Latex')
xlabel('Batches','Interpreter','Latex')
print(gcf,'-dpng','../AEFigures/fig_stress_response_rho.png', '-r600')
print(gcf,'-dsvg','../AEFigures/fig_stress_response_rho.svg')


fig2=newfigure(3,2); 
set(gca,'FontSize',12);
hold on
plot(ts,mes,'-', 'LineWidth',2, 'DisplayName','Eff. species, $m_e$');
% ylabel('Eff. species, $m_e$','Interpreter','Latex')
xlabel('Batches','Interpreter','Latex')

% print(gcf,'-dpng','../AEFigures/fig_stress_response_me.png', '-r600')
% print(gcf,'-dsvg','../AEFigures/fig_stress_response_me.svg')

%fig2=newfigure(3,1.75); 
%set(gca,'FontSize',12);
hold on
plot(ts,Ps*10,'-', 'LineWidth',2, 'DisplayName','Nutrient 1, $P$');
% ylabel('Nutrient 1, $P$',Interpreter','Latex')
xlabel('Batches','Interpreter','Latex')
l =legend('show','Interpreter','Latex');
l.Position = [ 0.4557    0.2760    0.5315    0.2113];
print(gcf,'-dpng','../AEFigures/fig_stress_response_P.png', '-r600')
print(gcf,'-dsvg','../AEFigures/fig_stress_response_P.svg')
