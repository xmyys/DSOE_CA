data = [];
data1 = data(1:round(size(data, 1)/3),:);
data2 = data(round(size(data, 1)/3)+1:round(size(data, 1)/3)*2,:);
data3 = data(round(size(data, 1)/3)*2+1:size(data, 1),:);
n = 100;
idx1 = randperm(size(data1, 1), n);
idx2 = randperm(size(data2, 1), n);
idx3 = randperm(size(data3, 1), n);
point1 = data(idx1, :);
ponit2 = data(idx2, :);
point3 = data(idx3, :);
points = [point1;ponit2;point3];
for i=1:size(points,1)
    if points(i,1) < 0
        points(i,:) = -points(i,:);
    end
end
