function J=jacobfun(t,y,params)
% Returns Jacobian matrix for the diffeq solver

J = zeros(length(y), length(y));
c_i = y(1:params.p);
rho_sigma = y((params.p+1):end);
derivative_ci = params.K./((c_i+params.K).^2);
monod = c_i./(c_i+params.K);
for ii=1:params.p
    J(ii,ii) = -derivative_ci(ii)*sum(rho_sigma.*params.alpha(:,ii));
    J(ii,(params.p+1):end) = -monod(ii)*params.alpha(:,ii)';
end

for ss=1:params.m
    sigma = ss+params.p;
    J(sigma,ii)= derivative_ci(ii)*rho_sigma(ss)*params.alpha(ss,ii);
    J(sigma,sigma) = params.alpha(ss,:)*monod;           
end