function D = SVMDistance(X1, X2)

kernel = 'gaussian';
kerneloption = 1;
nu = 0.01;
p1 = size(X1,2);
p2 = size(X2,2);

[xsup1, alpha1, rho1, pos1, Ksup1] = svmoneclass(X1, kernel, kerneloption, nu, false);
[xsup2, alpha2, rho2, pos2, Ksup2] = svmoneclass(X2, kernel, kerneloption, nu, false);

w1 = sum(repmat(alpha1, 1, p1).*xsup1);
w2 = sum(repmat(alpha2, 1, p2).*xsup2);

W1W2 = alpha1' * svmoneclassval(xsup1, xsup2, alpha2, 0, kernel, kerneloption);
normW1 = sqrt(alpha1'*Ksup1*alpha1);
normW2 = sqrt(alpha2'*Ksup2*alpha2);

c1c2 = acos(W1W2 / (normW1 * normW2));

c1p1 = acos(-rho1/sqrt(alpha1' * Ksup1 * alpha1));
c2p2 = acos(-rho2/sqrt(alpha2' * Ksup2 * alpha2));

D = c1c2/(c1p1 + c2p2);
D = real(D);

% [xtest1, xtest2] = meshgrid(-10:0.5:10 ,-10:0.5:10) ;
% 
% nn = length(xtest1);
% Xgrid = [reshape(xtest1, nn*nn,1) reshape(xtest2 ,nn*nn,1) ];
% ypred = svmoneclassval(Xgrid, xsup1, alpha1, rho1, kernel, kerneloption);
% ypred = reshape(ypred,nn,nn);
% contourf(xtest1 ,xtest2 ,ypred ,50) ; shading flat;
% hold on;
% [cc,hh]=contour(xtest1 ,xtest2 ,ypred ,[-1 0 1] , 'k') ;
% clabel(cc,hh) ;
% set(hh, 'LineWidth', 2) ;
% colorbar
% hold on
% plot(X1(:,1),X1(:,2), '.')

