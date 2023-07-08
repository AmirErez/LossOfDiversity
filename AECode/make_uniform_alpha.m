%s - strategy matrix
function alpha = make_uniform_alpha(alpha_val, m)
    vs = linspace(alpha_val, 1-alpha_val, m);
    alpha = zeros(m,2);
    for j =1:m
        alpha(j,1) = vs(j);
        alpha(j,2) = 1 - vs(j);
    end
end