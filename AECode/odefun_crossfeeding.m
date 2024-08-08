function dydt = odefun_crossfeeding(t,y,params)
% In the form of dy/dt = f(y). Include both c_i and rho_sigma.

c_i = y(1:params.p);
rho_sigma=y((params.p+1):end);
monod_i = (c_i./(params.K + c_i));
dydt = zeros(length(c_i)+length(rho_sigma),1);
sum_sigma_rho_J = monod_i.*transpose(sum(params.alpha.*repmat(rho_sigma,1,params.p)));
dydt(1:params.p) = -sum_sigma_rho_J + params.Gamma*sum_sigma_rho_J; 
dydt((params.p+1):end) = rho_sigma.*(params.alpha*monod_i);
end

