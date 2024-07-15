function [normal, orientation] = kdtree(points, k)
% k = 20;
a = points;
vec = zeros(size(a));
q = zeros(length(a),1);
 
% k = 20;
neighbors = knnsearch(a(:,1:3),a(:,1:3), 'k', k+1);
for i = 1:length(a)
    curtemp = neighbors(i,2:end);
    indpoint = a(curtemp,:);
    [v, c] = eig(cov(indpoint));
    c = diag(c)';
    z = sum(c);
    p1 = c(:,1)/z;
    q(i,:) = abs(p1);
    vec(i,:) = v(:,1)';
end

normal = vec;
for i=1:size(normal,1)
    if normal(i,1) < 0
        normal(i,:) = -normal(i,:);
    end
end

orientation = zeros(size(normal,1),2);
for i=1:size(normal,1)
    if normal(i,3) >= 0
        orientation(i,1) = rad2deg(acos(normal(i,2)/sqrt(normal(i,1)^2+normal(i,2)^2)));
    else
        orientation(i,1) = rad2deg(2*pi-acos(-normal(i,2)/sqrt(normal(i,1)^2+normal(i,2)^2)));
    end
    orientation(i,2) = rad2deg(acos(abs(normal(i,3))));
end

end
