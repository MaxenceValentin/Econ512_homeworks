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
eps = 1e-4; % convergence critirion
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
V = (-1)*(P - c)/0.1; % Start by discounting current profit by 10%

p_new = zeros(L,L);
V_new = zeros(L,L);

iter = 0;
check = 1;
while check > eps

    W = getW(V);   % Get continuation value for all possible state/future state combination
    
for om1 = 1:L % For all possible states
    for om2 = 1:L
        
        p1 = P(om1,om2);
        p2 = P(om2,om1);    % Set price of opponent fixed
        
        W_state =  reshape(W(om1,om2,:),[1,3]);      
        f = @(p1) (-1)*val(p1,p2,W_state,om1); %Maximize wrt to p1
        %q = @(p1) foc_indv(p1,p2,W_state,om1);
        p_new(om1,om2) = fminsearch(f,p1); 
        %[p_new2(om1,om2) , V_new2(om1,om2)] = fsolve(q,p1,options); 

        V_new(om1,om2) = f(p_new(om1,om2));
        
    end

end
    iter = iter +1
    if iter > 500
        break
    end
    check = max( max(max(abs((V_new - V)./(1+abs(V_new))))),  max(max(abs((p_new-P)./(1+abs(p_new))))))
    V = lambda * V_new + (1-lambda)*V; %Dampening
    P = lambda * p_new + (1-lambda)*P;

end

Policy = P;
Value = (-1)*V;

surf(Policy);
colorbar
title('Policy function')
ylabel('State player 1') 
xlabel('State player 2') 
surf(Value);
colorbar
title('Value function')
ylabel('State player 1') 
xlabel('State player 2') 

%% 
% Get distribution of states

B = 10000; %Nb of forward looking draws

i = 0;
for T = 10:10:30
i = i+1;
states(:,:,i) = simulate_states(Policy,T,B);
end
hist3(states(:,:,1),{0:1:30 0:1:30})
    xlabel('Omega 2')
    ylabel('Omega 1')
    title('Distribution of states after t = 10')

hist3(states(:,:,2),{0:1:30 0:1:30})
    xlabel('Omega 2')
    ylabel('Omega 1')
    title('Distribution of states after t = 20')

hist3(states(:,:,2),{0:1:30 0:1:30})
    xlabel('Omega 2')
    ylabel('Omega 1')
    title('Distribution of states after t = 30')

    
%% 
% Assuming symmetric equilibrium - the stationary distribution would solve
% pr(f|omega1 = omega2)= pr(sell | omega1 = omega2, Policy)

price_sym = diag(Policy);
prob_moves = delta_omega(omega)' - exp(v-price_sym(omega))./(1+2*exp(v-price_sym(omega)));

disp('The stationary state is omega1 = omega2 = 22')


%%
% See the evoluation of state distribution over time
i = 0;
for T = 10:10:500
i = i+1;
states(:,:,i) = simulate_states(Policy,T,B);
end

for j = 1:12
    subplot(3,4,j);
    hist3(states(:,:,j),{0:1:30 0:1:30})
    %xlabel('Omega 2')
    %ylabel('Omega 1')
    %title('Distribution of states after t =')
end
sgtitle('Distribution evolution over time')

% Animation
for j = 1:i
    hist3(states(:,:,j),{0:1:30 0:1:30})
    xlabel('Omega 2')
    ylabel('Omega 1')
    title('Distribution of states after t =')
    %drawnow
    pause(0.5)
end

save('distribution.mat','states')
