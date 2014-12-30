function X = regularizeCaracts(X, ps)

pBegin = 1;
ps = cumsum(ps);

for pEnd = ps
    X(:,pBegin:pEnd) = X(:,pBegin:pEnd)/max(max(X(:,pBegin:pEnd)));
    pBegin = pEnd + 1;
end