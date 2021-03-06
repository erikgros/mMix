function der = dxztds(xzt, s)
% xzt = (x, z, theta)
bot = -1; % -1/1 top/bottom meniscus (Bretherton)
 R = 3; % result very insensitive to this value
 der(1) = cos( xzt(3) ); %dxds
 der(2) = sin( xzt(3) ); %dzds
 if (s == 0)
  der(3) = -1 / R;
 else
  der(3) = bot*xzt(2) -sin( xzt(3) ) / xzt(1);
 end
end
