function val = val(p1,p2,W,om1)

global c beta v

den = (1+exp(v-p2)+exp(v-p1));

D(1) = (1)/den;
D(2) = (exp(v-p1))/den;
D(3) = (exp(v-p2))/den;

val = D(2)*(p1 - c(om1)) + beta * sum(D.*W);  

end
