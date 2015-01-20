function D = SVMDistance(X1, X2)

kernel = 'gaussian';
kerneloption = 1;
nu = 0.01;
p1 = size(X1,2);
p2 = size(X2,2);

[xsup1, alpha1, rho1, pos1, Ksup1] = svmoneclass(X1, kernel, kerneloption, nu, false);
[xsup2, alpha2, rho2, pos2, Ksup2] = svmoneclass(X2, kernel, kerneloption, nu, false);

w1w2 = alpha1' * svmoneclassval(xsup1, xsup2, alpha2, 0, kernel, kerneloption);
normW1 = sqrt(alpha1'*Ksup1*alpha1);
normW2 = sqrt(alpha2'*Ksup2*alpha2);

c1c2 = acos(w1w2 / (normW1 * normW2));

c1p1 = acos(-rho1/sqrt(alpha1' * Ksup1 * alpha1));
c2p2 = acos(-rho2/sqrt(alpha2' * Ksup2 * alpha2));

D = (c1c2 + 1e-8)/(c1p1 + c2p2 + 1e-8);
D = real(D);
