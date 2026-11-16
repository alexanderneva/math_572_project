m = 1; n=1;
a = 2; b = 1; K_A=3;K_B=3;
A = [-m,b,c_1;a,-n,d_1; c_2,d_2,-p];
r=0;
s=0;
q=0;
function v = wrapper(t,v,a,b,K_A,K_B,m,n,r,s)
  [x,y]=logistic_sys(a,b,K_A,K_B,m,n,r,s,v(1),v(2));
  v = [x;y];
endfunction
[X,Y]=meshgrid(linspace(-1,1,20));
[U,V]=logistic_sys(a,b,K_A,K_B,m,n,r,s,X,Y);
L = hypot(U,V);
[~,yf]=ode45(@(t,v)wrapper(t,v,a,b,K_A,K_B,m,n,r,s),[0,1],[0;-0.5]);
[~,yb]=ode45(@(t,v)wrapper(t,v,a,b,K_A,K_B,m,n,r,s),[0,-1/3],[0;-0.5]);
hold on;
quiver(X,Y,U./L,V./L);
plot(yf(:,1),yf(:,2));
plot(yb(:,1),yb(:,2));
axis equal; grid on;
hold off;
theta = linspace(-pi/2,pi/2,8);
theta(end)=[];
phi = linspace(0,2*pi,8);
phi(end)=[];
[THETA,PHI] = meshgrid(theta,phi);
