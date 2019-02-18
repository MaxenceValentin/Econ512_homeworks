function foc_indv = foc_indv(p1,p2,W,om1)

global c beta v

den = (1+exp(v-p2)+exp(v-p1));
den_sq = den^2;

D(1) = (1)/den;
D(2) = (exp(v-p1))/den;
D(3) = (exp(v-p2))/den;

%D_prime(1) = exp(v-p1)/den_sq;
%D_prime(2) = (exp(v-p1)*exp(v-p1))/den_sq - D(2);
%D_prime(3) = exp(v-p1)/den_sq;

foc_indv = 1 - (1 - D(2))*(v-c(om1)) - beta*W(2) + beta*sum(D.*W);  

end
