classdef camera < dynamicprops
    properties
        position
        orientation
        imageWidth
        imageHeight
        fx
        fy
        cc
        alpha_c
        kc
        %%
        dronePoints
        %%
        imagePoints
    end
    methods
        function obj = camera(position, orientation, width, height, fx, fy, cc, alpha_c, kc)
            obj.position = position;
            obj.orientation = orientation;
            obj.imageWidth = width;
            obj.imageHeight = height;
            obj.fx = fx;
            obj.fy = fy;
            obj.cc= cc;
            obj.alpha_c = alpha_c;
            obj.kc = kc;
        end
        
        function draw(obj)
            cameraFrame = eye(3) * obj.orientation';
            drawFrame(obj.position, 250, cameraFrame(1, :)',   cameraFrame(2, :)',  cameraFrame(3, :)');
            
            cLinesBasic = [obj.imageWidth / 2 / obj.fx, obj.imageHeight / 2 / obj.fy, 1;...
                -obj.imageWidth / 2 / obj.fx, obj.imageHeight / 2 / obj.fy, 1;...
                obj.imageWidth / 2 / obj.fx, -obj.imageHeight / 2 / obj.fy, 1;...
               -obj.imageWidth / 2 / obj.fx, -obj.imageHeight / 2 / obj.fy, 1;];
            scale = 2000;
            cLines = transformOut(LjNormalize(cLinesBasic) * scale, obj);
            myLine(obj.position, cLines(1, :), 'color', 'm', 'linewidth', 1);
            myLine(obj.position, cLines(2, :), 'color', 'm', 'linewidth', 1);
            myLine(obj.position, cLines(3, :), 'color', 'm', 'linewidth', 1);
            myLine(obj.position, cLines(4, :), 'color', 'm', 'linewidth', 1);
        end
        
        function obj = lookAtDrone(obj, drone)
            obj.dronePoints = transformIn(transformOut(drone.points, drone), obj);
            obj.imagePoints = obj.project2Image(obj.dronePoints);
            
            obj.checkConsistance();
        end
        
        function imagePoints = project2Image(obj, XX)
            xn = [XX(:, 1) ./ XX(:, 3), XX(:, 2) ./ XX(:, 3)];
            rs = xn(:, 1).^2 + xn(:, 2).^2;
            scale = 1 + obj.kc(1) * rs + obj.kc(2) * rs.^2 + obj.kc(5) * rs.^3;
            dx = [2 *obj.kc(3) * xn(:, 1) .* xn(:, 2) + obj.kc(4) * (rs + 2 * xn(:, 1).^2), ...
                obj.kc(3) * (rs + 2 * xn(:, 2).^2) + 2 * obj.kc(4) * xn(:, 1) .* xn(:, 2)];
            xd = repmat(scale, 1, 2) .* xn + dx;
            imagePoints = [obj.fx * (xd(:, 1) + obj.alpha_c * xd(:, 2)) + obj.cc(1), ...
                obj.fy * xd(:, 2) + obj.cc(2)];
        end
        
        function U = recoverDistortion(obj, mpImage)
            U = normalize(mpImage', [obj.fx, obj.fy], obj.cc, obj.kc, obj.alpha_c)';
            U = [U, ones(size(U, 1), 1)];
        end
        
        function checkConsistance(obj)
            U = obj.recoverDistortion(obj.imagePoints);
            U = U(:, 1:2);
            realU = zeros(size(U));
            realU(:, 1) = obj.dronePoints(:, 1) ./ obj.dronePoints(:, 3);
            realU(:, 2) = obj.dronePoints(:, 2) ./ obj.dronePoints(:, 3);
            
            tError = sum(abs(realU(:) - U(:)));
            if tError > 1e-8
                error('inconsistant projection!');
            end
        end
    end
end