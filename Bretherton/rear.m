a = 0;
b = -50;
tole = 0.000001;

function [ y, P, Q, R ] = rea( alpha, a, b, xi )
% beta = alpha, gamma = 0 in (16)
 ec = exp(-a/2)*cos(sqrt(3)*a/2);
 es = exp(-a/2)*sin(sqrt(3)*a/2);
 y = lsode( "ode11", [1+alpha*ec; -alpha*0.5*(ec+es*sqrt(3)); alpha*0.25*(ec*(1-3)+es*(sqrt(3)+1))], xi );
 P = y(end,3);
 Q = y(end,2) - P * b;
 R = y(end,1) - b * (b * P / 2 + Q);
endfunction

xi = linspace (a, b, 1000);
dQ = 1;
alp = 0.4821;
alpOld = 0.4;
while ( abs(dQ) > tole ) % secant method:
 [ eta, P, Qold, R ] = rea( alpOld, a, b, xi );
 [ eta, P, Q   , R ] = rea( alp   , a, b, xi );
 dQ = Qold - Q;
 dalp = Qold * ( alp - alpOld ) / dQ;
 alp = alpOld;
 alpOld = alpOld + dalp;
end
 P
 Q
 R
 plot( xi, eta(:,1) )
