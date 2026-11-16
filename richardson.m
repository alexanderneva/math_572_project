a = 3;
b = 3;
m = 5;
n = 5;
r=1;
s=1;
A = [-m, a; b, -n];
q = [r;s];
x_star = -inv(A)*q;
sys = @(A,q,v) A*v+q;
[vecs, lambda] = eig(A);
point = linspace(0,2*pi,32);
point(end)=[];
ini = [cos(point(:))+x_star(1),sin(point(:))+x_star(2)];
[X,Y] = meshgrid(linspace(-1,1,20));
%X = X-x_star(1);
%Y = Y-x_star(2);
U = A(1,1)*X + A(1,2)*Y+q(1);
V = A(2,1)*X + A(2,2)*Y+q(2);
L = hypot(U,V);
L(L==0)=1;
U = U./L;
V = V./L;
fig = figure();
subplot(2,1,1);
hold on;
t = linspace(-1,1,15);
quiver(X,Y,U,V);
for k=1:size(ini,1)
  y_0 = ini(k,:)';
  [~,yf] = ode45(@(t,v) sys(A,q,v), [0,1], y_0);
  [~,yb] = ode45(@(t,v) sys(A,q,v), [0,-1], y_0);
  plot(yf(:,1),yf(:,2));
  plot(yb(:,1),yb(:,2));
endfor
plot(t+x_star(1),(vecs(2,1)/vecs(1,1))*t+x_star(2),'k','LineWidth',1.);
plot(t+x_star(1),(vecs(2,2)/vecs(1,2)) *t+x_star(2),'k','LineWidth',1.);
X_N = (a/m)*(t-x_star(2))+x_star(1);
NX_U = zeros(size(X_N));
NX_V = A(2,1)*X_N+A(2,2)*t+q(2);
L = hypot(NX_U,NX_V);
L(L==0)=1;
quiver(X_N,t,0.1*(NX_U./L),0.1*(NX_V./L),0,'m','LineWidth',1.);
NX = plot(X_N,t,'r','DisplayName','x-nullcline','LineWidth',1.);
Y_N = (b/n)*(t-x_star(1))+x_star(2);
NY_U = A(1,1)*t+A(1,2)*Y_N+q(1);
NY_V = zeros(size(Y_N));
L = hypot(NY_U,NY_V);
L(L==0)=1;
NY = quiver(t,Y_N,0.1*(NY_U./L),0.1*(NY_V./L),0,'m','LineWidth',1.);
NY=plot(t,Y_N,'g','DisplayName','y-nullcline','LineWidth',1.);
eq=plot(x_star(1),x_star(2),'o','MarkerSize',5,
'MarkerFaceColor','r','DisplayName',
sprintf('Equilibrium (%g, %g)',x_star(1),x_star(2)));
hold off;
title(sprintf("Relational spending, m=%g n=%g a=%g, b=%g \n r=%g s=%g Det(A) = %g ",m,n,a,b,r,s,det(A)));
xlabel("Nation A");
ylabel("Nation B");
xlim([-1,1]);
ylim([-1,1]);
legend([eq,NX,NY],'Location','northwest');
subplot(2,1,2);
[X,Y] = meshgrid(linspace(-1,1,25));
a = 5;
b = 5;
m = 3;
n = 3;
A = [-m, a; b, -n];
q = [r;s];
x_star = -inv(A)*q;
sys = @(A,q,v) A*v+q;
[vecs, lambda] = eig(A);
%X = X - x_star(1);
%Y = Y - x_star(2);
U = A(1,1)*X + A(1,2)*Y+q(1);
V = A(2,1)*X + A(2,2)*Y+q(2);
L = hypot(U,V);
L(L==0)=1;
U = U./L;
V = V./L;
hold on;
quiver(X,Y,U,V);
for k=1:size(ini,1)
  y_0 = ini(k,:)';
  [~,yf] = ode45(@(t,v) sys(A,q,v), [0,1], y_0);
  [~,yb] = ode45(@(t,v) sys(A,q,v), [0,-1], y_0);
  plot(yf(:,1),yf(:,2));
  plot(yb(:,1),yb(:,2));
endfor
plot(t+x_star(1),(vecs(2,1))/vecs(1,1)*t+x_star(2),'k','LineWidth',1.);
plot(t+x_star(1),(vecs(2,2))/vecs(1,2)*t+x_star(2),'k','LineWidth',1.);
X_N = (a/m)*(t-x_star(2))+x_star(1);
NX_U = zeros(size(X_N));
NX_V = A(2,1)*X_N+A(2,2)*t+q(2);
L = hypot(NX_U,NX_V);
L(L==0)=1;
NX = quiver(X_N,t,0.1*(NX_U./L),0.1*(NX_V./L),0,'m','LineWidth',1.);
NX = plot(X_N,t,'r','DisplayName','x-nullcline','LineWidth',1.);
Y_N = (b/n)*(t-x_star(1))+x_star(2);
NY_U = A(1,1)*t+A(1,2)*Y_N+q(1);
NY_V = zeros(size(Y_N));
L = hypot(NY_U,NY_V);
L(L==0)=1;
NY = quiver(t,Y_N,0.1*(NY_U./L),0.1*(NY_V./L),0,'m','LineWidth',1.);
NY=plot(t,Y_N,'g','DisplayName','y-nullcline','LineWidth',1.);
eq=plot(x_star(1),x_star(2),'o','MarkerSize',5,
'MarkerFaceColor','r','DisplayName',
sprintf('Equilibrium (%g, %g)',x_star(1),x_star(2)));
title(sprintf("Relational spending, m=%g n=%g a=%g, b=%g \n r=%g, s=%g, Det(A) = %g ",m,n,a,b,r,s,det(A)));
xlabel("Nation A");
ylabel("Nation B");
xlim([-1,1]);
ylim([-1,1]);
legend([eq,NX,NY],'Location','northwest');
print('figures/richardson_curves.png', '-dpng', '-S1300,1300');



