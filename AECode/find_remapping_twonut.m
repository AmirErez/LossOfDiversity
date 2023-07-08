function P = find_remapping_twonut(params)
% Returns the remapping point closest to nutrient 1 when there are two
% nutrients

if params.p~=2
    error('Only works with p=2 nutrients.')
end
mx = max(params.alpha(:,1));

%options = optimoptions('fsolve', 'FunctionTolerance', 1e-7,...
%    'StepTolerance', 1e-7, 'Display', 'iter', 'Algorithm', 'levenberg-marquardt');
options = optimoptions('fsolve', 'FunctionTolerance', 1e-11,...
    'Display', 'iter', 'Algorithm', 'levenberg-marquardt');
% [nut1val fval exitflag output] = fzero(@(P1) calc_diff(params,P1), [mx-0.1, mx+0.1]);
nut1val = fsolve(@(P1) calc_diff(params,P1), mx-0.1, options);


% options = optimoptions('fmincon','Display','iter'); % Display iterations
% [nut1val, fval] = fmincon(@(P1) calc_diff(params,P1),mx-0.01,[],[],[],[],0.5,mx);
disp(['  Finished optimization with P1=' num2str(nut1val) ]); %' ; and fval ' num2str(fval) ]);
P = [nut1val; 1-nut1val];
return


function dif = calc_diff(params,P1)
    temp_params = params;
    if(P1>1)
        % dif = 100000*(P1-1);
        dif = 1e4;
        return;
    end
    if(P1<0)
%        dif = -100000*P1;
        dif = 1e4;
        return;
    end
    temp_params.P = [P1; 1-P1];
    output = serialdil_odesolver(temp_params,0);
    % diff1 = diff(output.NutIntegrals(:,end))/sum(output.NutIntegrals(:,end));
    diff1 = abs(output.NutIntegrals(2,end)-output.NutIntegrals(1,end));
    diff2 = output.ShannonS(end);
    %dif = max(abs([diff1, diff2]));
    dif = sqrt(diff1^2+diff2^2);
end


end
