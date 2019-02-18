function [pr1 pr2] = prob(p1,p2)
global v
den = 1 + exp(v-p1) + exp(v-p2);

pr1 = exp(v-p1)/den;
pr2 = exp(v-p2)/den;
%prob(3) = 1/den;


end