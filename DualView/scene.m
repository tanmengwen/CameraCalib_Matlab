classdef scene < dynamicprops
    properties
        leftCamera
        rightCamera
        drone
        %%
        R
        T
    end
    
    methods
        function obj = scene()
            obj.leftCamera = 0;
            obj.rightCamera = 0;
            obj.drone = 0;
        end
        
        function obj = setup(obj, draw)
            obj.leftCamera = obj.setupLeftCamera(draw);
            obj.R = LjRotation(0, -pi / 2, 0);
            obj.T = [-1000, 0, 1000];
            obj.rightCamera = obj.setupRightCamera(obj.R, obj.T, draw);
            
            obj.drone = obj.setupDrone(draw);
        end
        
        function obj = init(obj)
            obj.leftCamera = obj.leftCamera.lookAtDrone(obj.drone);
            obj.rightCamera = obj.rightCamera.lookAtDrone(obj.drone);
        end
        
        function droneIns = setupDrone(obj, draw)
            droneIns = drone([0, 0, 1000] * sqrt(2) / 2, LjRotation(0, 0, 0), 100);
            if draw == 1
                droneIns.draw();
            end
        end
        
        function cameraIns = setupLeftCamera(obj, draw)
            cameraIns = camera([-500, 0, 0] * sqrt(2), ...
                LjRotation(0, -pi / 4, 0), 1024, 768, 1451, 1447, [523, 395], 0.0, ...
                [0.08341, -1.18218, -0.00206, 0.00730, 0.00000]);
            if draw == 1
                cameraIns.draw();
            end
        end
        
        function cameraIns = setupRightCamera(obj, R, T, draw)
            rightCameraPosition = obj.leftCamera.position - (obj.leftCamera.orientation * R' * T')';
            rightCameraOrientation = obj.leftCamera.orientation * R';
            cameraIns = camera(rightCameraPosition, rightCameraOrientation, ...
                1024, 768, 1451, 1447, [523, 395], 0.0, ...
                [0.08341, -1.18218, -0.00206, 0.00730, 0.00000]);
            if draw == 1
                cameraIns.draw();
            end
        end
        
        function PError = reconstruct(obj)
            U1 = obj.leftCamera.recoverDistortion(obj.leftCamera.imagePoints);
            U2 = obj.rightCamera.recoverDistortion(obj.rightCamera.imagePoints);
            
            N = size(U1, 1);
            coefs = zeros(N, 2);
            for i = 1 : N
                u1 = U1(i, :)';
                u2 = U2(i, :)';
                A = [(obj.R * u1)' * (obj.R * u1), -(obj.R * u1)' * u2; ...
                    -u2' * (obj.R * u1), u2' * u2];
                B = [-(obj.R * u1)' * obj.T'; u2' * obj.T'];
                coefs(i, :) = (A \ B)';
            end
            reconPoints = U1 .* repmat(coefs(:, 1), 1, 3);
            
            PError = mean(abs(reconPoints - obj.leftCamera.dronePoints));
            %fprintf('PError  :  %15.14g  %15.14g  %15.14g\n', PError);
        end
    end
end