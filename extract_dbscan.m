function labels = extract_dbscan(data, orders, reach_dists, eps)

[n, ~] = size(data);

reach_distIds = find(reach_dists(orders) <= eps);

pre = reach_distIds(1) - 1;
clusterId = 0;
labels = -1 * ones(n,1);
for i = 1:length(reach_distIds)
    current = reach_distIds(i);
    if (current - pre ~= 1)
        clusterId = clusterId + 1;
    end
    labels(orders(current)) = clusterId;
    pre = current;
end
labels = labels + 2;
end