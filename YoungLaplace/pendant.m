% Shape of a pendant drop and top | bottom of rising bubble as described by:
%   (+|-)z / Lc^2 + z" / (1 + z'^2)^3/2 + z' r^-1 / (1 + z'^2)^1/2 = 0
% Using dimensionless form, lengths are scaled by Lc = sqrt(sig / (rho*g)).
% The physical parameters only determine the scaling via Lc.
% The tip of drop has radius R and elevation z0 = 2 / R.
% Also interesting: "https://link.springer.com/book/10.1007%2F978-1-4613-8584-4"
N = 500; % number of points

function [h dhdr dydt2] = zr(R, z0, t)
%%% primitive method %%%
 h = z0 * ones(length(t),1);
 y = z0 * ones(2,1); % y(1) = z; y(2) = z'
 dt = t(2) - t(1);
 for i=1:length(t)-1
  if (i==1)
   y(2) = -dt * 1 / R;
  else
   dydt1 = y(2);
   dydt2 = -(1 + y(2).^2) .* y(2) ./ t(i) - y(1) .* (1 + y(2).^2)^(3/2);
%   dydt2 = - y(1) .* (1 + y(2).^2)^(3/2); % (2d)
   y(1) += dt * dydt1;
   y(2) += dt * dydt2;
  end
  h(i+1) = y(1);
  dhdr(i+1) = y(2);
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%

col = ['r','b','g','y'];

R = 1.15 * sqrt(0.842); % tip radius
for k = 1:4
 z0 = 2 / R;
% r = linspace (0, R, N); % radius
% [z dzdr d2zdr2I] = zr(R, z0, r);
% plot( r(1:10:end), z(1:10:end), [col(k) "+"] );hold on;
% using xzt formulation (requires max(s) = pi*R):
 s = linspace (0, pi*R, N); % arc length
 a = lsode( "dxztds", [0 z0 0], s);
 plot( a(1:1:end,1), a(1:1:end,2), [col(k) "-"] );hold on;
 R *= 1/1.15;
end
xlabel('r'); ylabel('z')
return
% comparing with analytical solution for 2d:
 drdz = -tan( asin((z.*z-z0*z0)/2 + 1));
 figure(2); plot( r, dzdr, 'r*', r, 1./drdz); legend('numerical','analytical')
