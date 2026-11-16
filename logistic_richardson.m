m = 1; n=2;
a = 2; b = 1; K_A=1;K_B=1;
A = [-m,b,c_1;a,-n,d_1; c_2,d_2,-p];
r=0;
s=0;
phi = linspace(0,2*pi,16);
phi(end)=[];
ini = [cos(phi(:)),sin(phi(:))];
function v = wrapper(t,v,a,b,K_A,K_B,m,n,r,s)
  [x,y]=logistic_sys(a,b,K_A,K_B,m,n,r,s,v(1),v(2));
  v = [x;y];
endfunction
colors = lines(size(x,1));
hold on;
[X,Y]=meshgrid(linspace(-1,1,20));
[U,V]=logistic_sys(a,b,K_A,K_B,m,n,r,s,X,Y);
L = hypot(U,V);
quiver(X,Y,U./L,V./L);
for k=1:size(x,1)
  y0 = ini(k,:)';
  [~,yf]=ode45(@(t,v)wrapper(t,v,a,b,K_A,K_B,m,n,r,s),[0,1],y0);
  [~,yb]=ode45(@(t,v)wrapper(t,v,a,b,K_A,K_B,m,n,r,s),[0,-1],y0);
  h = plot(yf(:,1),yf(:,2),'Color',colors(k,:),'LineWidth',1.);
  plot(yb(:,1),yb(:,2),'Color',colors(k,:),'LineWidth',1.);
endfor
xlim([-1,1])
ylim([-1,1])
axis equal; grid on;
hold off;
