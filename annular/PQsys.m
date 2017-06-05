function [y, PP, QQ] = PQsys(x, P, Q)
% PP/P: computed/prescribed outer mass flow rate
% QQ/Q: computed/prescribed inner mass flow rate
% y = (PP-P, QQ-Q)
 Ri = x(1);
 G1 = x(2);
 G2 = -4;

% parameters:
 R = 1.0;
 rho1 = 1;
 rho2 = 1000;
 mu1 = 0.01;
 mu2 = 0.01;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
 delt = G2 - G1;
 c1 = (G2 * (Ri*Ri - R*R) * 0.5 + delt * Ri*Ri * log(R/Ri) ) * 0.5 / mu2 - G1 * Ri*Ri * 0.25 / mu1;
 c2 = (delt * Ri*Ri * log(R) - G2 * R*R * 0.5) * 0.5 / mu2;
 d2 = -delt * Ri*Ri * 0.5 / mu2;

 PP = pi * rho2 * (G2 * R^4 * 0.125 / mu2 + R*R * (c2 + d2 * (log(R) - 0.5)) - G2 * Ri^4 * 0.125 / mu2 - Ri*Ri * (c2 + d2 * (log(Ri) - 0.5)));
 QQ = pi * rho1 * (G1 * Ri^4 * 0.125 / mu1 + c1 * Ri*Ri);

 y = zeros(2,1);
 y(1) = PP - P;
 y(2) = QQ - Q;
endfunction
