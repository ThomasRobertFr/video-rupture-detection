function D = calculDifference(A1, A2, signal)

n = size(signal,1);

D = zeros(n - A2 - A1 - 1,1);

i = 1;
for k = A1 + 1:n - A2
    signalDiff = abs(mean(signal(k:k+A2-1, :)) - mean(signal(k-A1:k, :)));
    D(i) = sum(signalDiff);
    i = i + 1;
end
