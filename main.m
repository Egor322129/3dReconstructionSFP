n_ind = 1.5;
t0 = clock;
%--------------------------------Init-----------------------------------
img0 = rgb2gray(imread('IMG_18.ppm'));
img1 = rgb2gray(imread('IMG_19.ppm'));
img2 = rgb2gray(imread('IMG_20.ppm'));
img3 = rgb2gray(imread('IMG_21.ppm'));
img4 = rgb2gray(imread('IMG_22.ppm'));
img5 = rgb2gray(imread('IMG_23.ppm'));
img6 = rgb2gray(imread('IMG_24.ppm'));
img7 = rgb2gray(imread('IMG_25.ppm'));
img8 = rgb2gray(imread('IMG_26.ppm')); 
mask = logical(rgb2gray(imread('mask.pbm')));


[m,n] = size(img0);
phi_map = zeros(m,n);
theta_map = zeros(m,n);
Iun_map = zeros(m,n);
%-----------------------------------------------------------------------

for i = 205:1200
    for j = 663:1869
            psi = [0 pi/8 2*pi/8 3*pi/8 4*pi/8 5*pi/8 6*pi/8 7*pi/8 pi ]'; 
            I = [ img0(i,j) img1(i,j) img2(i,j) img3(i,j) img4(i,j) img5(i,j) img6(i,j) img7(i,j) img8(i,j) ]'; 
            [phi, Iun, rho] = Sfp(I, psi);
            phi_map(i, j) = phi;
            theta_map(i, j) = acos(((2*rho + 2*n_ind^2*rho - 2*n_ind^2 + n_ind^4 + rho^2 + 4*n_ind^2*rho^2 - n_ind^4*rho^2 - 4*n_ind^3*rho*(-(rho - 1)*(rho + 1))^(1/2) + 1)/(n_ind^4*rho^2 + 2*n_ind^4*rho + n_ind^4 + 6*n_ind^2*rho^2 + 4*n_ind^2*rho - 2*n_ind^2 + rho^2 + 2*rho + 1))^(1/2));
            Iun_map(i,j) = Iun;
    end
end

t = etime(clock, t0);
disp(['SFP took ' num2str(t) ' seconds']);

[l, T, B] = findLight(theta_map, phi_map, Iun_map, mask, 3);


