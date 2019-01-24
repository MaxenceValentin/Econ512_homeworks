
rng(36);
boot = 1000;
period = 20;
p1 = 1;
init_stock = 100;

consumption = zeros(period,boot);
stocks = zeros(period,boot);

for j = 1:boot
stock = init_stock;

r = normrnd(mu_error,std_error,[1,20]);
closestIndex = zeros(period,1);
pt = p1;
[a,closestIndex(1)] = min(abs(pt-grid));

for i = 2:period %Get closer price point on grid
pt = p0 + rho*pt + r(i);
[a,closestIndex(i)] = min(abs(pt-grid));
end


    for i = 1:period %Loop through different optimal policies
    stocks(i,j) = stock;
    consumption(i,j) = policy(stock,closestIndex(i));
    stock = stocks(i,j) - consumption(i,j);
    end

end

clear a stock closestIndex r pt boot init_stock period
