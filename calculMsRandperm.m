function Ms = calculMsRandperm(A1, A2, signal, n)

Ms = zeros(n,1);

for i = 1:n
    signalPerm = signal(randperm(size(signal,1)), :);
    Ms(i) = max(calculDifference(A1, A2, signalPerm));
end

