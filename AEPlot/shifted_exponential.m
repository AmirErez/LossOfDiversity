function [a,b,c] = shifted_exponential(xx,yy)
% Fits shifted exponential y = a+b*exp(c*x)
% Without optimization, using 
% https://stackoverflow.com/questions/3938042/fitting-exponential-decay-with-no-initial-guessing
% and specifically,
% https://www.scribd.com/doc/14674814/Regressions-et-equations-integrales
% https://scikit-guess.readthedocs.io/en/latest/appendices/reei/translation.html#reei1-paper
% https://scikit-guess.readthedocs.io/en/latest/appendices/reei/translation.html#regression-of-functions-of-the-form-y-x-a-b-text-exp-c-x

    
    if(size(xx,2)>size(xx,1)), xx = xx'; end
    if(size(yy,2)>size(yy,1)), yy = yy'; end
    S = zeros(size(xx));
    S(1) = 0;
    S(2:end) = cumsum(0.5*diff(xx).*(yy(2:end)+yy(1:(end-1))));
    
    M=zeros(2,2);
    M(1,1) = sum((xx-xx(1)).^2);
    M(1,2) = sum((xx-xx(1)).*S);
    M(2,1) = M(1,2);
    M(2,2) = sum(S.^2);

    invM = inv(M);
    res = invM * [ sum((yy-yy(1)).*(xx-xx(1))) ;  sum((yy-yy(1)).*S)  ];
    c = res(2);

    M2=zeros(2,2);
    M2(1,1) = length(yy);
    M2(1,2) = sum(exp(c*xx));
    M2(2,1) = M2(1,2);
    M2(2,2) = sum(exp(2*c*xx));
    invM2 = inv(M2);
    res = invM2*[ sum(yy) ;  sum(yy.*exp(c*xx))  ];
    a = res(1);
    b = res(2);
end

