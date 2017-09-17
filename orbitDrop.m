% What is the shape of an orbiting drop?
% Is the shape elongated and rotating such that it shows always the same face to the center?
% If the velocity field is that of rigid body rotations there are no viscous stresses.
% Is this the only way to let the viscous stress vanish? If so can friction damp all motion strong enough such that the orbit will end as solid body rotation?

% Following code is solving for the shape of an orbiting drop with simplifications...
rho = 1000; % water drop
m_E = 5.974e24; % mass of the earth in kg
m_M = 7.349e22; % mass of the moon in kg
D_E = 12756e3; % dimeter of the earth
d_EM = 30 * D_E; % average distance moon-earth in km
g = 9.81;
G = 6.67408e-11;
%this is only half the story because g_M depends on y
g_M = G * m_M / d_EM^2;
R = d_EM * m_M / ( m_M + m_E ); % distance earth center of mass
omega = sqrt( g_M  / R );
C = 0;
X = linspace(-D_E,D_E);
Y = linspace(-D_E,D_E);
[x,y] = meshgrid(X,Y);
p = omega^2 * ( R * y + 0.5 * y.^2 ) - g_M * y - g * sqrt( x.^2 + y.^2 );
p = rho * p;
contour(x,y,p)
xlabel("x"); ylabel("y")
hold on;

% plotting circle with earth radius
y_E = sqrt( (D_E/2)^2 - X.^2 );
plot(X, y_E, 'bk')
plot(X, -y_E, 'bk')
axis equal
