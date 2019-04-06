function [phi, Iun, rho] = Sfp (I, psi) 
    A = ([ones( 9,1) cos(2*psi) sin(2*psi)]);
    I = double(I);
    V = pinv(A)*(2*I);
    P = V(1); 
    Q = V(2);
    H = V(3);
    Imax = 0.5*(P + sqrt(Q^2 + H^2));
    Imin = 0.5*(P - sqrt(Q^2 + H^2));
    phi = 0.5*atan2(H, Q);
    Iun = (Imax + Imin) / 2; 
    rho = (Imax-Imin)/(Imax+Imin);
end