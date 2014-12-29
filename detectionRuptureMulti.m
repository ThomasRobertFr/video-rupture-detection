function [zones, points] = detectionRuptureMulti(D, C)

zonesC = cell(1, length(D));

for i=1:length(D)
    zonesC{i} = D{i} > C{i};
end

zones = zeros(size(zonesC{1}));

for i=1:length(zonesC)
    zones = zones + zonesC{i};
end

zones = zones / length(zonesC);

zones = floor(zones);

points = [];

Dmoy = calculVectMoy(D);

ruptStart = 1;
for i = 2:length(zones)
    if zones(i) == 1 && zones(i-1) == 0
        ruptStart = i;
    elseif (zones(i) == 0 && zones(i-1) == 1)
        [~, argmax] = max(Dmoy(ruptStart:i));
        points(end+1) = ruptStart + argmax;
    end
end
