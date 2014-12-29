function Dmoy = calculVectMoy(D)
    Dmoy = zeros(size(D{1}));
    for i=1:length(D)
        Dmoy = Dmoy + D{i}/max(D{i});
    end
end