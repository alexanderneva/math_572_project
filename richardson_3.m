m = 10; n=1; p=10;
a = 1; b = 1; c_1 =0.5; c_2=1; d_1=2;d_2=3;
A = [-m,b,c_1;a,-n,d_1; c_2,d_2,-p];
r=0;
s=0;
q=0;
w = [r;s;q];
x_star = -inv(A)*w;
theta = linspace(-pi/2,pi/2,8);
theta(end)=[];
phi = linspace(0,2*pi,8);
phi(end)=[];
[THETA,PHI] = meshgrid(theta,phi);
[x,y,z] = sph2cart(PHI,THETA,1);
ini = [x(:), y(:), z(:)]+x_star';
sys = @(A,w,v) A*v+w;
[vecs, lambda] = eig(A);
[X,Y,Z] = meshgrid(linspace(-1,1,8));
X = X + x_star(1);
Y = Y + x_star(2);
Z = Z + x_star(3);
U = A(1,1)*X + A(1,2)*Y + A(1,3)*Z + w(1);
V = A(2,1)*X + A(2,2)*Y + A(2,3)*Z + w(2);
W = A(3,1)*X + A(3,2)*Y + A(3,3)*Z + w(3);
L = sqrt(U.^2 + V.^2 + W.^2);
fig = figure();
hold on;
s = [-1, 1];
for i=1:3
  l1 = x_star(i)+vecs(:,i)*s;
  L1=plot3(l1(1,:),l1(2,:),l1(3,:),'k','DisplayName',sprintf('Line %g',i),'LineWidth',1);
endfor
pl = @(x, y) (m / c_2) * x + (-a / c_2) * y;
ezsurf(pl,[-1,1]);
pl = @(x,y) (-b/d_2)*x + (n/d_2)*y;
ezsurf(pl,[-1,1]);
pl = @(x,y) (c_1/p)*x + (d_1/p)*y;
ezsurf(pl,[-1,1]);
%quiver3(X,Y,Z,0.1*(U./L),0.1*(V./L),0.1*(W./L),0);
for k=1:size(ini,1)
  y_0 = ini(k,:)';
  [~,yf] = ode45(@(t,v) sys(A,w,v), [0,1], y_0);
  [~,yb] = ode45(@(t,v) sys(A,w,v), [0,-1], y_0);
  plot3(yf(:,1),yf(:,2),yf(:,3));
  plot3(yb(:,1),yb(:,2),yb(:,3));
endfor
eq=plot3(x_star(1),x_star(2),x_star(3),'o','MarkerSize',10,
'MarkerFaceColor','r','DisplayName','Equilibrium');
view(45,20);
title(sprintf("Relational spending, m=%g n=%g p=%g \n a=%g, b=%g \n c_1=%g c_2=%g d_1=%g d_2=%g \n r=%g s=%g q=%g Det(A) = %g ",
m,n,p,a,b,c_1,c_2,d_1,d_2,r,s,q,det(A)));
xlabel("Nation A");
ylabel("Nation B");
zlabel("Nation C");
axis equal; grid on;
xlim([-2,2]+x_star(1));
ylim([-2,2]+x_star(2));
zlim([-2,2]+x_star(3));
legend([L1,eq]);
hold off;
print(fig,sprintf('figures/richardson_3D_%g_%g_%g.png',r,s,q),
'-dpng', '-S1300,1300');
%close(fig);
