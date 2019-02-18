 % Homework 7: ECON512


%%
% Set parameters
clear all;

global L rho kappa l v delta beta eps delta_omega c lambda;
L = 30; % Number of states
rho = 0.85; % learning curve parameter
kappa = 10; % minimal know-how
l = 15; % cap of know-how
v = 10; % value of good
delta = 0.03; % depreciation 
beta = 1/1.05; % discounting parameter
eps = 1e-6; % convergence critirion
lambda = 0.9; %Dampening parameters
eta = log(rho)/log(2);

omega = 1:1:L;
delta_omega = 1 - (1-delta).^omega;

% Cost function
c = zeros(L,1);
c(1:(l-1)) = kappa*omega(1:(l-1)).^eta; 
c(l:L) = kappa*l^eta;

c_vec = repmat(c,30,1);


%%

% Initial value
P = ones(L,L)*8;
V = (P - c)/0.1; % Start by discounting current profit by 10%

p_new = zeros(L,L);
V_new = zeros(L,L);

iter = 0;
check = 1;
iter = 0;
options = optimset('TolX', 1e-12, 'TolFun', 1e-12);

while check > eps

    W = getW(V);  
    P2 = P';  
       
    f = @(P) (-1)*val(P,P2,W);
    p_new = fminsearch(f,P);   
    V_new = val(p_new,P2,W);
    
    
    iter = iter +1;
    if iter > 100
        break
    end
    check = max( max(max(abs((V_new - V)./(1+abs(V_new))))),  max(max(abs((p_new-P)./(1+abs(p_new))))))
    V = lambda * V_new + (1-lambda)*V;
    P = lambda * p_new + (1-lambda)*P;

end





