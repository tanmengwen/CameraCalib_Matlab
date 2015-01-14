function localPoints = transformIn(globalPoints, object)

R = object.orientation';
T = (-object.orientation' * object.position')';
localPoints = globalPoints * R' + repmat(T, size(globalPoints, 1), 1);

end