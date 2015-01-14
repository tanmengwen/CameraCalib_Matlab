function globalPoints = transformOut(localPoints, object)

R = object.orientation;
T = object.position;
globalPoints = localPoints * R' + repmat(T, size(localPoints, 1), 1);

end