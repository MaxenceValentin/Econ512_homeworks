function foc = foc(p1,p2,W10,W11,W12,c_vec)

global beta v

den = (1+exp(v-p2)+exp(v-p1));

D0 = 1./den;
D1 = (exp(v-p1))./den;
D2 = (exp(v-p2))./den;

foc = 1 - (1 + D1).*(p1 - c_vec) - beta*W11 + beta * (D0.*W10 + D1.*W11 + D2.*W12);


end
