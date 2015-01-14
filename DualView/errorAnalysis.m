function errorAnalysis()
cameraErrorAnalysis();
imageErrorAnalysis();
relativePositionAndOrientationErrorAnalysis()
end

function cameraErrorAnalysis()
err.camera = camera([-500, 0, 0] * sqrt(2), ...
    LjRotation(0, -pi / 4, 0), 1024, 768, 1451, 1447, [512, 384], 0.0, zeros(1, 5));
err.drone = drone([0, 0, 1000] * sqrt(2) / 2, LjRotation(0, 0, 0), 100);
err.camera.lookAtDrone(err.drone);
oriImagePoints = err.camera.imagePoints;
N = 500;
errors = zeros(N, 2);
figure(1)
%% focal length error
fErrors = linspace(-10, 10, N);
oriFx = err.camera.fx;
oriFy = err.camera.fy;
for i = 1 : N
    err.camera.fx = oriFx + fErrors(i);
    err.camera.fy = oriFy + fErrors(i);
    err.camera = err.camera.lookAtDrone(err.drone);
    errors(i, :) = mean(abs(err.camera.imagePoints - oriImagePoints));
end
subplot(4, 1, 1)
plot(fErrors, errors);
xlabel('focal length bias(pixel)')
ylabel('image point error(pixel)')
legend('\Delta{x}', '\Delta{y}');
err.camera.fx = oriFx;
err.camera.fy = oriFy;
%% cc error
ccErrors = linspace(-10, 10, N);
oriCc = err.camera.cc;
for i = 1 : N
    err.camera.cc = oriCc + [ccErrors(i), ccErrors(i)];
    err.camera = err.camera.lookAtDrone(err.drone);
    errors(i, :) = mean(abs(err.camera.imagePoints - oriImagePoints));
end
subplot(4, 1, 2)
plot(ccErrors, errors);
xlabel('cc bias(pixel)')
ylabel('image point error(pixel)')
legend('\Delta{x}', '\Delta{y}');
err.camera.cc = oriCc;
%% kc error
kcBasic = [0.08341, -1.18218, -0.00206, 0.00730, 0.00000];
scales = linspace(-3, 3, N);
oriKc = err.camera.kc;
for i = 1 : N
    err.camera.kc = kcBasic * scales(i);
    err.camera = err.camera.lookAtDrone(err.drone);
    errors(i, :) = mean(abs(err.camera.imagePoints - oriImagePoints));
end
subplot(4, 1, 3)
plot(scales, errors);
xlabel('kc scales(ratio)')
ylabel('image point error(pixel)')
legend('\Delta{x}', '\Delta{y}');
err.camera.kc = oriKc;
err.camera = err.camera.lookAtDrone(err.drone);
%% alpha_c error
alphaCErrors = linspace(-0.1, 0.1, 500);
oriAlphaC = err.camera.alpha_c;
for i = 1 : N
    err.camera.alpha_c = alphaCErrors(i);
    err.camera = err.camera.lookAtDrone(err.drone);
    errors(i, :) = mean(abs(err.camera.imagePoints - oriImagePoints));
end
subplot(4, 1, 4)
plot(alphaCErrors, errors);
xlabel('alpha\_c error')
ylabel('image point error(pixel)')
legend('\Delta{x}', '\Delta{y}');
err.camera.alpha_c = oriAlphaC;
end

function imageErrorAnalysis()
%%  feature points extraction error
S = scene();
S = S.setup(0);
S = S.init();
N = 500;

errors = zeros(N, 3);
scales = linspace(0, 3, N);
leftImagePoints = S.leftCamera.imagePoints;
rightImagePoints = S.rightCamera.imagePoints;
NP = size(S.leftCamera.imagePoints, 1);
leftImageErrorBasic = 2 * rand(NP, 2) - 1;
rightImageErrorBasic = 2 * rand(NP, 2) - 1;
for i = 1 : N
    leftImageError = scales(i) * leftImageErrorBasic;
    rightImageError = scales(i) * rightImageErrorBasic;
    S.leftCamera.imagePoints = leftImagePoints + leftImageError;
    S.rightCamera.imagePoints = rightImagePoints + rightImageError;
    errors(i, :) = reconstruct(S);
end
figure(2)
plot(scales, errors);
xlabel('feature points extraction error(pixel)')
ylabel('mean reconstrction error(mm)')
legend('\Delta{x}', '\Delta{y}', '\Delta{z}');
end

function relativePositionAndOrientationErrorAnalysis()
%% R error
S = scene();
S = S.setup(0);
S = S.init();
N = 500;
figure(3)

RError = linspace(-2, 2, N);
errors = zeros(N, 3);
oriR = S.R;
for i = 1 : N
    S.R = oriR * LjRotation(RError(i) / 180 * pi, RError(i) / 180 * pi , RError(i) / 180 * pi);
    errors(i, :) = S.reconstruct();
end
subplot(3, 1, 1)
plot(RError, errors);
xlabel('rotation error(degree)')
ylabel('mean reconstrction error(mm)')
legend('\Delta{x}', '\Delta{y}', '\Delta{z}');
S.R = oriR;
%% T error
TError = linspace(-10, 10, N);
oriT = S.T;
for i = 1 : N
    S.T = oriT + [TError(i), TError(i), TError(i)];
    errors(i, :) = S.reconstruct();
end
subplot(3, 1, 2)
plot(TError, errors);
xlabel('translation error(mm)')
ylabel('mean reconstrction error(mm)')
legend('\Delta{x}', '\Delta{y}', '\Delta{z}');
S.T = oriT;
%% R and T error
for i = 1 : N
    S.R = oriR * LjRotation(RError(i) / 180 * pi, RError(i) / 180 * pi , RError(i) / 180 * pi);
    S.T = oriT + ones(1, 3) * TError(i);
    errors(i, :) = S.reconstruct();
end
subplot(3, 1, 3)
plot(TError, errors);
xlabel('rotation error(-2^o, 2^o) translation error(-10, 10mm)')
ylabel('mean reconstrction error(mm)')
legend('\Delta{x}', '\Delta{y}', '\Delta{z}');
S.R = oriR;
S.T = oriT;
end