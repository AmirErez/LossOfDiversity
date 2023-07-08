function dydt = odefun(t,y,params)
% In the form of dy/dt = f(y). Include both c_i and rho_sigma.

c_i = y(1:params.p);
rho_sigma=y((params.p+1):end);
dydt = zeros(length(c_i)+length(rho_sigma),1);
dydt(1:params.p) = -(c_i./(params.K + c_i)).*transpose(sum(params.alpha.*repmat(rho_sigma,1,params.p)));
dydt((params.p+1):end) = rho_sigma.*(params.alpha*(c_i./(params.K + c_i)));
end

