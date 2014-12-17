function [zones, points] = detectionRupture(D, C)

zones = D > C;
points = [];

ruptStart = 1;
for i = 2:length(zones)
    if zones(i) == 1 && zones(i-1) == 0
        ruptStart = i;
    elseif (zones(i) == 0 && zones(i-1) == 1)
        [~, argmax] = max(D(ruptStart:i));
        points(end+1) = ruptStart + argmax;
    end
end
