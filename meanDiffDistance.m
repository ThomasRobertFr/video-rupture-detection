function D = meanDiffDistance(X1, X2)

D = sum(abs(mean(X1) - mean(X2)));