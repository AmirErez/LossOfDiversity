function P_trajectory = make_P_trajectory(Pinit, Pfinal, num_steps)
% Returns p x num_steps matrix ramping Pinit to Pfinal

if(min(size(Pinit)==size(Pfinal))==0)
    error('Cannot create trajectory. Mismatch Pinit and Pfinal')
end

P_trajectory = nan*zeros(size(Pinit,1),num_steps);

for ii=1:size(Pinit,1)
    P_trajectory(ii,:) = linspace(Pinit(ii), Pfinal(ii), num_steps);
end


end