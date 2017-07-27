% plotting the isolines for a bipolar corrdinate system
h=0.1;
phi0=acos(1-2*h);

figure(1);hold on;axis equal
for k=0:4
 isophi(phi0+k*pi/4, phi0)
end
pause(3)
for k=-10:10
 isoxi(k, phi0)
end
