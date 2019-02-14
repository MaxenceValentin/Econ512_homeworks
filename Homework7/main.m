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
lambda = 0.8; %Dampening parameters
eta = log(rho)/log(2);

omega = 1:1:L;
delta_omega = 1 - (1-delta).^omega;

% Cost function
c = zeros(L,1);
c(1:(l-1)) = kappa*omega(1:(l-1)).^eta; 
c(l:L) = kappa*l^eta;


%%

% Initial value
P = ones(L,L)*8;
V = (P - c)/0.1; % Start by discounting current profit by 10%

p_new = zeros(L,L);
V_new = zeros(L,L);

iter = 0;
check = 1;
iter = 0;
while check > eps

    W = getW(V);   
    
for om1 = 1:L
    
    for om2 = 1:L
        
        p1 = P(om1,om2);
        p2 = P(om2,om1);
        
        W_state =  reshape(W(om1,om2,:),[1,3]);      
        f = @(p1) (-1)*val(p1,p2,W_state,om1);

        p_new(om1,om2) = fminsearch(f,p1); 
        
        V_new(om1,om2) = f(p_new(om1,om2));
    end

end
    iter = iter +1;
    if iter > 500
        break
    end
    check = max( max(max(abs((V_new - V)./(1+abs(V_new))))),  max(max(abs((p_new-P)./(1+abs(p_new))))));
    V = lambda * V_new + (1-lambda)*V;
    P = lambda * p_new + (1-lambda)*P;

end






