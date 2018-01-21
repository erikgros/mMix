% Shape of a liquid marble
%  2/R - z kap^2 + z" / (1 + z'^2)^3/2 + z' r^-1 / (1 + z'^2)^1/2 = 0
%  where "R" is the radius of curvature at the top (z=z'=0)

N = 50; % number of points
kap = 1/3;

function [vol] = rotVol( a )
 rsq = a(:, 1).^2;
 vol = pi * trapz( -a(:, 2), rsq );
end

for R0 = [ 0.5 1 2.4 4.8 8.8 ]
V = (4*pi/3)*(R0)^3;
V0 = V * (kap)^3;
theta = linspace (0, -pi, N);

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
  a = a ./ kap;
  plot( a(:, 1), a(:, 2) ); hold on % like Fig 9
  wall = min(a(:, 2)) * ones(N,1);
  plot( a(:, 1), wall );
  axis([0 15 -8 0]); xlabel('r'); ylabel('z')
  axis equal
  break
 end
 slope = (dV2-dV1) / (c2-c1);
 c2 = c1;
 c1 -= dV1 / slope;
end
if k == 20
 disp("did not converge")
 return
end
end
