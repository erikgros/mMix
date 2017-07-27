function isophi( phi, phi0 )
xi = linspace(-10, 10, 1000);

% stratified flow
x = -sinh( xi ) .* sin( phi0 ) ./ (cosh(xi) - cos(phi));
y = (cos(phi - phi0) - cosh(xi) .*  cos(phi0)) ./ (cosh(xi) - cos(phi));

plot(x, y)
end
