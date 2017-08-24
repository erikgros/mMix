function dydt = ode11(y, t)
 dydt = zeros(3,1);
 dydt(1) = y(2);
 dydt(2) = y(3);
 dydt(3) = ( y(1) .- 1 ) ./ (y(1).^3);
endfunction
