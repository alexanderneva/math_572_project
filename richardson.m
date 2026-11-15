a = 3;
b = 3;
m = 5;
n = 5;
r=2;
s=-2;
A = [-m, a; b, -n];
q = [r;s];
x_star = -inv(A)*q;
sys = @(A,q,v) A*v+q
[vecs, lambda] = eig(A);
point = linspace(0,2*pi,32)
point(end)=[];
ini = [cos(point(:))-x_star(1),sin(point(:))-x_star(1)];
%[t,y] = ode45(@(t,v) sys(A), [-1,1], ini);
[X,Y] = meshgrid(linspace(-1,1,25));
U = A(1,1)*X + A(1,2)*Y+q(1);
V = A(2,1)*X + A(2,2)*Y+q(2);
L = hypot(U,V);
L(L_V==0)=1;
U = U./L;
V = V./L;
fig = figure();
subplot(2,1,1);
hold on;
t = linspace(-0.3,0.3,25);
quiver(X,Y,U,V);
for k=1:size(ini,1)
  y_0 = ini(k,:);
  [~,y] = ode45(@(t,v) sys(A,q,v), [-1,1], y_0);
  plot(y(:,1),y(:,2));
endfor
plot(t+x_star(1),(vecs(2,1)/vecs(1,1))*t+x_star(2),'LineWidth',1.,'k');
plot(t+x_star(1),(vecs(2,2)/vecs(1,2)) *t+x_star(2),'LineWidth',1.,'k');
hold off;
title(sprintf("Relational spending, m=%g n=%g a=%g, b=%g \n r=%g s=%g Det(A) = %g ",m,n,a,b,r,s,det(A)));
xlabel("Nation A");
ylabel("Nation B");
xlim([-1,1]);
ylim([-1,1]);
subplot(2,1,2);
a = 5;
b = 5;
m = 3;
n = 3;
A = [-m, a; b, -n];
X = X - x_star(1);
Y = Y - x_star(2);
U = A(1,1)*X + A(1,2)*Y+q(1);
V = A(2,1)*X + A(2,2)*Y+q(2);
L = hypot(U,V);
L(L_V==0)=1;
U = U./L;
V = V./L;
hold on;
quiver(X,Y,U,V);
for k=1:size(ini,1)
  y_0 = ini(k,:);
  [~,y] = ode45(@(t,v) sys(A,q,v), [-1,1], y_0);
  plot(y(:,1),y(:,2));
endfor
plot(t+x_star(1),(vecs(2,1))/vecs(1,1)*t+x_star(2),'LineWidth',1.,'k');
plot(t+x_star(1),(vecs(2,2))/vecs(1,2)*t+x_star(2),'LineWidth',1.,'k');
hold off;
title(sprintf("Relational spending, m=%g n=%g a=%g, b=%g \n r=%g, s=%g, Det(A) = %g ",m,n,a,b,r,s,det(A)));
xlabel("Nation A");
ylabel("Nation B");
xlim([-1,1]);
ylim([-1,1]);
print('figures/richardson_curves.png', '-dpng', '-S1300,1300');



