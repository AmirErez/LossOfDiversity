function S=calc_entropy_nats(rho)
% Returns the entropy in nats


S = NaN*zeros(size(rho, 2),1);
for ii=1:size(rho, 2)
    r = abs(rho);
    norm_b = r(:,ii)/sum(r(:,ii));
    lognorm = log(norm_b);
    lognorm(lognorm==-Inf) = 0;
    S(ii) = -sum(norm_b.*lognorm);
end
