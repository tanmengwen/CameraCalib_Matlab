
ip = [512; 384];

om = [1.570796326794897; 0; 0];
T = [0; 1; 1];
omN = rodrigues(LjRotation(1 * pi / 180, 1 * pi / 180, 1 * pi / 180) * rodrigues(om));

[XL, XR] = stereo_triangulation(ip, ip, omN, T, [1451, 1447], [512 384], zeros(1, 5), 0, [1451, 1447], [512 384], zeros(1, 5), 0)

u1 = rodrigues(omN) * [0; 0; 1];
u2 = [0; 0; 1];
coef = fminunc(@(x) sum((x(1) * u2 - T - x(2) * u1).^2), [0; 0]);

%XR = coef(1) * u2
XR = T + coef(2) * u1
XL = rodrigues(omN)' * (XR - T)
