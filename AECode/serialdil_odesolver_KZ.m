function output = serialdil_odesolver_KZ(params, P_trajectory, plt)

% Amir Erez 2022-04-22.
% This function simulates serial dilutions  Kibble Zurek on P_trajectory of
% nutrients

output = struct;
output.burnin=struct;
output.burnin.rho = zeros(params.m, params.max_batches);
output.burnin.NutIntegrals = zeros(params.p, params.max_batches);

params.rho_initial = params.b0;
tol = 1e-10;
er=Inf;

% First, thermalize to params.max_batches. Only after, do ramp.
params.P = P_trajectory(:,1);
for cnt=1:params.max_batches  
    if(mod(cnt,1000)==0)
       disp(['   Done ' num2str(cnt) '  ;  err ' num2str(max(er))]);
    end
    %Simulate batch
    [rho_sigma, Nr] = multispeciesbatch_odesolver(params,0);
    params.b0=rho_sigma(:,end)/sum(rho_sigma(:,end));
    output.burnin.rho(:,cnt) = params.b0*params.rho0;
    output.burnin.NutIntegrals(:, cnt) = Nr';

    %Compute relative error between batches of populations or diversity
    if(cnt>1)
        if params.errtype == 1
            er = abs((output.burnin.rho(:,cnt) - output.burnin.rho(:,cnt-1)))/sum(output.burnin.rho(:,cnt));
        else
            Pcurr = output.burnin.rho(:,cnt)/sum(output.burnin.rho(:,cnt));
            Dcurr = -sum(Pcurr.*log(Pcurr));
            Pprev = output.burnin.rho(:,cnt-1)/sum(output.burnin.rho(:,cnt-1));
            Dprev = -sum(Pprev.*log(Pprev));
            er = abs((Dcurr - Dprev)/Dcurr);
        end
    
        if max(er) < tol %Exit loop of error below threshold
            break;

        end
    end
end


%PROCESS DATA--------------------------------------------------------------

output.burnin.rho = output.burnin.rho(:,1:cnt);
output.burnin.NutIntegrals = output.burnin.NutIntegrals(:, 1:cnt);
output.burnin.ShannonS = calc_entropy_nats(output.burnin.rho);

%Now start KZ ramp
disp('Starting KZ ramp')
ramplen = size(P_trajectory,2);
output.rho = zeros(params.m, ramplen);
output.rho(:,1) = output.burnin.rho(:, end);
output.NutIntegrals = zeros(params.p, ramplen);
output.NutIntegrals(:,1) = output.burnin.NutIntegrals(:,end);

for cnt=2:ramplen 
    %Simulate batch
    if(mod(cnt,1000) == 0)
        disp(['  Done ' num2str(cnt)])
    end
    params.P = P_trajectory(:,cnt);
    [rho_sigma, Nr] = multispeciesbatch_odesolver(params,0);
    params.b0=rho_sigma(:,end)/sum(rho_sigma(:,end));
    output.rho(:,cnt) = params.b0*params.rho0;
    output.NutIntegrals(:, cnt) = Nr';
end

if plt ~= 0
    disp('Plt function deprecated.')
end

end

