% experiment of Fermi, Pasta, Ulam
addpath('../')
N=500;
Nt=5000;
dt=0.00125;
d=0.022;

D0 = eye(N);
[x, D1] = fourdif(N, 1);
[x, D3] = fourdif(N, 3);

u=cos(x);
for k=0:Nt
 if ( mod(k,500) == 0 )
  plot(x,u)
  xlim([0 2*pi])
  ylim([-1 2.5])
  pause(1)
 end
% A = D0/dt + d*d * D3; % linear
 A = D0/dt + diag(u)*D1 + d*d * D3; % KDV
 b = u/dt; u = A \ b;
end

return % check time convergence:
plot(x,u,'go')
hold on
dt=dt/2;
u=cos(x);
for k=1:Nt
 A = D0/dt + diag(u)*D1 + d*d * D3;
 b = u/dt; u = A \ b;
end
plot(x,u)
