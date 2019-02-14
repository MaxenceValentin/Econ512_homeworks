function states = simulate_states(Policy,T,B)

global v delta L
states = zeros(B,2);
random = rand(B,T,3); %To generate transition

for b = 1:B

om1 = 1;
om2 = 1;
for t = 1:T

p1 = Policy(om1,om2);
p2 = Policy(om2,om1);

% Get transition 
den = 1 + exp(v-p1) + exp(v-p2);
pr0 = 1/den;
pr1 = exp(v-p1)/den;
pr2 = exp(v-p2)/den;

PR = [0,pr0,pr0+pr1,1];
sell = discretize(random(b,t,1),PR)-1;

if sell == 1
    up1 = 1;
    up2 = 0;
elseif sell ==2
    up1 = 0;
    up2 = 1;
else
    up1 = 0;
    up2 = 0;
end

if random(b,t,2)<=1-(1-delta)^om1 %Compute depreciation shocks
  down1=1;
else
  down1=0;
end
if random(b,t,3)<=1-(1-delta)^om2
  down2=1;
else
  down2=0;
end


om1 = om1 - down1 + up1;
om2 = om2 - down2 + up2;

if om1 == 0 % Make sure we stay within the states
    om1 = 1;
elseif om1 == L+1
    om1 = L;
end

if om2 == 0 % Make sure we stay within the states
    om2 = 1;
elseif om2 == L+1
    om2 = L;
end

end

states(b,1) = om1;
states(b,2) = om2;

end