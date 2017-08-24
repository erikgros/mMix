% only front for now
r = 0.1;
Ca = 0.00001;

front
b = (3 * Ca)^(2/3) * P * r
y = b * eta(:,1);
x = b * xi * (3 * Ca)^(-1/3);

plot(x, y)
disp('Usually: y >> r! Consistent?')
