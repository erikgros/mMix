% Cylindrical "Wasserhauttheorie"
L = 3;
N = 100;
dx = L / N;
Mflux = 50;

Ris = zeros(N+1,1);
Gs = zeros(N+1,1);
% initial values:
Ris(1) = 0.8; % film
Gs(1) = -4; % pressure gradient

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
arg0 = [Ris(1) Gs(1)];
[dum, P0, Q0] = PQsys(arg0, 0, 0);
x=[0:dx:L];
for k = 0:N
 Q = Q0 + Mflux * x(k+1);
 P = P0 - Mflux * x(k+1);

 if k==0
  gRi = Ris(1);
  gG = Gs(1);
 else
  gRi = Ris(k);
  gG = Gs(k);
 end

 % solving 2x2 system for G? and Ri:
 fun = @(y) PQsys(y, P, Q);
 [u, fval, info] = fsolve(fun, [gRi; gG])
 Ris(k+1) = u(1);
 Gs(k+1) = u(2);
end
plot(x, Ris)
ylim([0, 1])
