% Shape of a static drop on a surface for a given volume and contact angle
% equation in tps:
%  2/R - z Eo + z" / (1 + z'^2)^3/2 + z' r^-1 / (1 + z'^2)^1/2 = 0
%  where "R" is the radius of curvature at the top (z=z'=0)
%Is an analytical solution possible?

Eo = 50;
Vtps = 2.2973100625
N = 500; % number of points
CA = 80 *pi/180;

function [vol] = rotVol( a )
 rsq = a(:, 1).^2;
 vol = pi * trapz( -a(:, 2), rsq );
end

V0 = Vtps * (sqrt(Eo))^3;
theta = linspace (0, -CA, N);

c1 = 1;
c2 = 10;
k = 0;
while ( k < 20 )
 k+=1;
 % secant method:
 xdot = @(rz,t) drzdt(rz, t, c2);
 a = lsode( xdot, [0 0], theta);
 dV2 = rotVol(a) - V0

 xdot = @(rz,t) drzdt(rz, t, c1);
 a = lsode( xdot, [0 0], theta);
 dV1 = rotVol(a) - V0

 if abs( dV1 ) < 1e-5
  a = a ./ sqrt(Eo);
  %plot( a(:, 1), a(:, 2) )
  %axis equal; xlabel('r'); ylabel('z')
  disp("Writing file dropSurf.dat")
  save -ascii dropSurf.dat a
  return
 end
 slope = (dV2-dV1) / (c2-c1);
 c2 = c1;
 c1 -= dV1 / slope;
end
disp("did not converge")
