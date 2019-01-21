% Answers to homework 6 for ECON512

%
%%
% % Parameters

clear all;
rho = 0.5;
p0 = 0.5;% unconditional mean 
K = [0:1:100];
mu_error = 0;
std_error = 0.1;
delta = 0.95;
N = 101;


%%

% Generate the Price (state variable) transition grid (Tauchen)

Z = 21; % Nb of grid points
[prob,grid]=tauchen(Z,p0,rho,std_error);


%%


V_beg=zeros(N,Z); %Value function beginning values
V = zeros(N,Z); % Value function new 
policy = zeros(N,Z); % Nb of trees to harvest in the K (remaining trees) x Price spaces
diff=1; % Control for stopping loop

% V is a N (nb of possible trees remaining) by Z (nb of possible price)
% Value function 

while diff>0.00001

EV = V_beg*prob';

for kstart = 0:100;
profits = zeros(N,Z);
for i = 1:N
    if kstart-(i-1) < 0 %kstart - (i-1) = X;
          profits(i,:) = -inf; 
    else
        for j = 1:Z 
        profits(i,j) = (kstart-(i-1))*grid(j) - 0.2*((kstart-(i-1))^1.5); %kstart - (i-1) = X;
        end
     end
end
[V((kstart+1),:) indx] = max(profits + delta*EV,[],1);
policy((kstart+1),:) = kstart - indx + 1 ; % Nb of harvested trees per price (column) for each starting K value (row)
end

diff=norm(V-V_beg)/norm(V);
V_beg=V;

end


%%
% Plotting results

% Value functions
plot(V(:,8))
hold on
plot(V(:,11))
plot(V(:,14))
legend('p=0.9','p=1','p=1.1')
title('Value functions as a function of initial stock')
xlabel('Initial stock') 
ylabel('Values') 
hold off


% Graph of optimal policy
plot(grid(:),policy(101,:))
hold on
plot(grid(:),policy(51,:))
plot(grid(:),policy(11,:))
legend('K=100','K=50','K=10')
title('Optimal harvesting strategy as a function of current prices and initial stock (K)')
xlabel('Current Prices') 
ylabel('Optimal policy') 
hold off


%%

% Redo with Tauchen of 5 points

Z = 5; % Nb of grid points
[prob,grid]=tauchen(Z,p0,rho,std_error);

V_beg=zeros(N,Z); %Value function beginning values
V = zeros(N,Z); % Value function new 
policy = zeros(N,Z); % Nb of trees to harvest in the K (remaining trees) x Price spaces
diff=1; % Control for stopping loop

% V is a N (nb of possible trees remaining) by Z (nb of possible price)
% Value function 

while diff>0.00001

EV = V_beg*prob';

for kstart = 0:100;
profits = zeros(N,Z);
for i = 1:N
    if kstart-(i-1) < 0 %kstart - (i-1) = X;
          profits(i,:) = -inf; 
    else
        for j = 1:Z 
        profits(i,j) = (kstart-(i-1))*grid(j) - 0.2*((kstart-(i-1))^1.5); %kstart - (i-1) = X;
        end
     end
end
[V((kstart+1),:) indx] = max(profits + delta*EV,[],1);
policy((kstart+1),:) = kstart - indx + 1 ; % Nb of harvested trees per price (column) for each starting K value (row)
end

diff=norm(V-V_beg)/norm(V);
V_beg=V;

end


%%
% Plotting results

% Value functions
plot(V(:,1))
hold on
plot(V(:,3))
plot(V(:,5))
legend('p=0.65','p=1','p=1.35')
title('Value functions as a function of initial stock')
xlabel('Initial stock') 
ylabel('Values') 
hold off

% Here the graph works as "expected"

% Graph of optimal policy
plot(grid(:),policy(101,:))
hold on
plot(grid(:),policy(51,:))
plot(grid(:),policy(11,:))
legend('K=100','K=50','K=10')
title('Optimal harvesting strategy as a function of current prices and initial stock (K)')
xlabel('Current Prices') 
ylabel('Optimal policy') 





%%








