function isoxi( xi, phi0 )
phi = linspace(phi0, phi0+pi, 1000);

% stratified flow
x = -sinh( xi ) .* sin( phi0 ) ./ (cosh(xi) - cos(phi));
y = (cos(phi - phi0) - cosh(xi) .*  cos(phi0)) ./ (cosh(xi) - cos(phi));

plot(x, y, 'r')
end
