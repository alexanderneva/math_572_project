function [x_p,y_p]=logistic_sys (a,b,K_A,K_B,m,n,r,s,x,y)
  x_p = a*(1-x./K_A).*y-m*x+r;
  y_p = b*(1-y./K_B).*x-n*y+s;
endfunction
