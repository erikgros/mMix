a = 0;
b = 50;
tole = 0.000001;

function [ y, P, Q, R ] = fron( alpha, a, b, xi )
 y = lsode( "ode11", [1+alpha*exp(a); alpha*exp(a); alpha*exp(a)], xi );
 P = y(end,3);
 Q = y(end,2) - P * b;
 R = y(end,1) - b * (b * P / 2 + Q);
endfunction

xi = linspace (a, b, 1000);
dQ = 1;
alp = 0.4821;
alpOld = 0.4;
while ( abs(dQ) > tole ) % secant method:
 [ eta, P, Qold, R ] = fron( alpOld, a, b, xi );
 [ eta, P, Q   , R ] = fron( alp   , a, b, xi );
 dQ = Qold - Q;
 dalp = Qold * ( alp - alpOld ) / dQ;
 alp = alpOld;
 alpOld = alpOld + dalp;
end
 P
 Q
 R
% plot( xi, eta(:,1) )
disp("Bretherton's values: P = 0.643, R = 2.79")
