m = 1; n=2; p=2;
a_2 = 0.1; a_3 = 0.1; b_1 =0.01; b_3=1; c_1=0.01;c_2=1;
A = [-m,b_1,c_1;a_2,-n,c_2; a_3,b_3,-p];
r=1;
s=-1;
q=1;
w = [r;s;q];
x_star = -inv(A)*w;
theta = linspace(0,pi/2,8);
theta(end)=[];
phi = linspace(0,pi/2,8);
phi(end)=[];
[THETA,PHI] = meshgrid(theta,phi);
[x,y,z] = sph2cart(PHI,THETA,1);
ini = [x(:), y(:), z(:)]+x_star';
sys = @(A,w,v) A*v+w;
[vecs, lambda] = eig(A);
[X,Y,Z] = meshgrid(linspace(0,2,8));
X = X + x_star(1);
Y = Y + x_star(2);
Z = Z + x_star(3);
U = A(1,1)*X + A(1,2)*Y + A(1,3)*Z + w(1);
V = A(2,1)*X + A(2,2)*Y + A(2,3)*Z + w(2);
W = A(3,1)*X + A(3,2)*Y + A(3,3)*Z + w(3);
L = sqrt(U.^2 + V.^2 + W.^2);
fig = figure();
colors = lines(size(ini,1));

hold on;
l = [-1, 1];
l1 = x_star+vecs(:,1)*l;
L1=plot3(l1(1,:),l1(2,:),l1(3,:),'k','DisplayName',...
sprintf('Eigenvector (%g, %g, %g)',vecs(1,1),vecs(2,1),vecs(3,1)),...
'LineWidth',1.2);
l2 = x_star+vecs(:,2)*l;
L2=plot3(l2(1,:),l2(2,:),l2(3,:),'k','DisplayName',...
sprintf('Eigenvector (%g, %g, %g)',vecs(1,2),vecs(2,2),vecs(3,2)),...
'LineWidth',1.2);
l3 = x_star+vecs(:,3)*l;
L3=plot3(l3(1,:),l3(2,:),l3(3,:),'k','DisplayName',...
sprintf('Eigenvector (%g, %g, %g)',vecs(1,3),vecs(2,3),vecs(3,3)),...
'LineWidth',1.2);
%pl = @(x, y) (m / c_2) * x + (-a / c_2) * y + x_star(3);
%ezsurf(@(x,y)[x+x_star(1),y+x_star(2),pl],[-1,1]);
%pl = @(x,y) (-b/d_2)*x + (n/d_2)*y + x_star;
%ezsurf(pl,[-1,1]);
%pl = @(x,y) (c_1/p)*x + (d_1/p)*y;
%ezsurf(pl,[-1,1]);
quiver3(X,Y,Z,0.2*(U./L),0.2*(V./L),0.2*(W./L),0);
for k=1:size(ini,1)
  y_0 = ini(k,:)';
  [~,yf] = ode45(@(t,v) sys(A,w,v), [0,1], y_0);
  [~,yb] = ode45(@(t,v) sys(A,w,v), [0,-1], y_0);
  plot3(yf(:,1),yf(:,2),yf(:,3),'Color',colors(k,:),'LineWidth',1.2);
  plot3(yb(:,1),yb(:,2),yb(:,3),'Color',colors(k,:),'LineWidth',1.2);
endfor
eq=plot3(x_star(1),x_star(2),x_star(3),'o','MarkerSize',10,
'MarkerFaceColor','r','DisplayName',
sprintf('Equilibrium (%g,%g,%g)',x_star(1),x_star(2),x_star(3)));
view(45,20);
view(-32,-25);
title(...
sprintf("Relational spending, m=%g n=%g p=%g \n a_2=%g, a_3=%g \n b_1=%g b_3=%g c_1=%g c_2=%g \n r=%g s=%g q=%g Det(A) = %g",
m,n,p,a_2,a_3,b_1,b_3,c_1,c_2,r,s,q,det(A)));
xlabel("Nation A");
ylabel("Nation B");
zlabel("Nation C");
axis equal; grid on;
xlim([0,2]+x_star(1));
ylim([0,2]+x_star(2));
zlim([0,2]+x_star(3));
legend([eq,L1,L2,L3]);
hold off;
print(fig,sprintf('figures/richardson_3D_%g_%g_%g.png',r,s,q),
'-dpng', '-S1300,1300');
%close(fig);
