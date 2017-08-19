function der = dxztds(xzt, s)
% xzt = (x, z, theta)
 der(1) = cos( xzt(3) ); %dxds
 der(2) = sin( xzt(3) ); %dzds
 if (s == 0)
  der(3) = -1;
 else
  der(3) = -xzt(2) -sin( xzt(3) ) / xzt(1);
 end
end
