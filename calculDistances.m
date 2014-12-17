function D = calculDistances(A1, A2, signal, distance)

n = size(signal,1);

D = zeros(n - A2 - A1 - 1,1);

i = 1;
for k = A1 + 1:n - A2
    D(i) = distance(signal(k:k+A2-1, :), signal(k-A1:k, :));
    i = i + 1;
end
