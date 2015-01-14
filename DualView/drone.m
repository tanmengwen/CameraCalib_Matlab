classdef drone
    properties
        position
        orientation
        distance
        points;
    end
    methods
        function obj = drone(position, orientation, distance)
            obj.position = position;
            obj.orientation = orientation;

            obj.distance = distance;
            obj.points = [obj.distance / 2, obj.distance / 2, 0; ...
                obj.distance / 2, -obj.distance / 2, 0; ...
                -obj.distance / 2, -obj.distance / 2, 0; ...
                -obj.distance / 2, obj.distance / 2, 0];
        end
        
        function draw(obj)
            bodyFrame = eye(3) * obj.orientation';
            drawFrame(obj.position, 250, bodyFrame(1, :)', bodyFrame(2, :)', bodyFrame(3, :)');

            bodyPointsInMatlabFrame = transformOut(obj.points, obj);
            patch(bodyPointsInMatlabFrame(:, 1), bodyPointsInMatlabFrame(:, 2), bodyPointsInMatlabFrame(:, 3), ...
                zeros(size(bodyPointsInMatlabFrame, 1), 1), 'facecolor', 'red', 'facealpha', 0.1);
        end
        
        function obj = setPosition(obj, position)
            obj.position = position;
        end
        
        function obj = setOrientation(obj, orientation)
            obj.orientation = orientation;
        end
        
        function obj = setDistance(obj, distance)
            obj.distance = distance;
            obj.points = [obj.distance / 2, obj.distance / 2, 0; ...
                obj.distance / 2, -obj.distance / 2, 0; ...
                -obj.distance / 2, -obj.distance / 2, 0; ...
                -obj.distance / 2, obj.distance / 2, 0];
        end
        
        function obj = setPoints(obj, points)
            obj.points = points;
        end
    end
end