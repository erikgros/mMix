function der = drzdt(rz, t, rEo)
% rz = (r, z); t = theta
z0 = 2 / rEo; % imposing top radius
if (t == 0 && rz(1) == 0)
 der(1) = -2 / z0;
 der(2) = 0;
else
 der(1) = rz(1) .* cos( t ) ./ ( rz(1) .* (rz(2)-z0) - sin( t ) ); %drdt
 der(2) = rz(1) .* sin( t ) ./ ( rz(1) .* (rz(2)-z0) - sin( t ) ); %dzdt
end
end
