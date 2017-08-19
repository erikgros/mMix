% The shape of a pendant drop/bubble is governed by:
% B z + z" / (1 + z'^2)^3/2 + ax * z' r^-1 / (1 + z'^2)^1/2 = 0
% see also: "https://link.springer.com/book/10.1007%2F978-1-4613-8584-4"
ax=1;
N=5001; % points

rho=1;
g=9.81;
sig=20;
Lc = sqrt(sig / (rho*g));

%%% primitive method %%%
R = Lc; % tip radius
B = Lc^(-2)
t = linspace (0, R, N); % radius
z = ones(N,2); dzdr = zeros(N,2);
y = z(1) * ones(2,1); % y(1) = z; y(2) = z'
dt = t(2) - t(1)
for i=1:N-1
 if (i==1)
  y(2) = -dt * 1 / R;
 else
  dydt1 = y(2);
  dydt2 = -ax * (1 + y(2).^2) .* y(2) ./ t(i) - B * y(1) .* (1 + y(2).^2)^(3/2);
  y(1) += dt * dydt1;
  y(2) += dt * dydt2;
 end
 z(i+1) = y(1);
 dzdr(i+1) = y(2);
end
%%%%%%%%%%%%%%%%%%%%%%%%

plot( t, z );hold on; xlabel('r'); ylabel('z')
if (ax == 0)
% comparing with analytical solution for 2d:
 drdz = tan( asin(B*t.*t/2 - 1));
 figure(2)
 plot( t, dzdr, t, 1./drdz, 'g' )
 legend('numerical','analytical')
else
% comparing with xzt formulation:
 x0 = 0;
 z0 = z(1) / Lc;
 s = t / Lc;
 a = lsode( "dxztds", [x0 z0 0], s);
 plot( Lc*a(:,1), Lc*a(:,2),'r' )
 legend('primitive','advanced')
end
%plot(t, sqrt(R*R - t.*t), 'bk') % circle
