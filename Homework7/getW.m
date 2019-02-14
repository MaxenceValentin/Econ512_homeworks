function W = getW(value)
global L delta_omega;


v = value;
W = zeros(L,L,3);


for om1 = 1:L
    for om2 = 1:L

W0 = 0;
W1 = 0;
W2 = 0;
for i = 1:L 
    
        if abs(i - om1) > 1 %Avoid computing meaningless transition
        prob1_q0 = 0; %if player 1 does not sell
        prob1_q1 = 0; %if player 1 sells
        
        elseif i == om1                     % Probability of not changing state
        prob1_q0 = (1-delta_omega(om1));
        prob1_q1 = delta_omega(om1);
            if i == L                   % Boundary probabilities
                prob1_q1 =1;
            elseif i == 1
                prob1_q0 = 1;
            end
        
        elseif i == om1-1    
        prob1_q0 = delta_omega(om1);
        prob1_q1 = 0;
        elseif i == om1+1
        prob1_q1 = (1-delta_omega(om1));
        prob1_q0 = 0;
        end 
        
        
    for j = 1:L
        
        if abs(j - om2) > 1 %Avoid computing meaningless transition
        prob2_q0 = 0; %if player 1 does not sell
        prob2_q1 = 0; %if player 1 sells
        
        elseif j == om2                     % Probability of not changing state
        prob2_q0 = (1-delta_omega(om2));
        prob2_q1 = delta_omega(om2);
            if j == L                   % Boundary probabilities
                prob2_q1 =1;
            elseif j == 1
                prob2_q0 = 1;
            end
        
        elseif j == om2-1    
        prob2_q0 = delta_omega(om2);
        prob2_q1 = 0;
        elseif i == om1+1
        prob2_q1 = (1-delta_omega(om2)); 
        prob2_q0 = 0;
        end 
        
        
        
        
        % Compute W
        a = v(i,j)*prob1_q0*prob2_q0;
        b = v(i,j)*prob1_q1*prob2_q0;
        c = v(i,j)*prob1_q0*prob2_q1;
        
        W0 = W0 + a;
        W1 = W1 + b;
        W2 = W2 + c;
    end
end
W(om1,om2,1) = W0;
W(om1,om2,2) = W1;
W(om1,om2,3) = W2;
end
end

end






