a = 0.5;
b = 2;
A = [0,a;b,0];
%model_1 = @(v) A * v'
omega = sqrt(a*b);
point = linspace(0,2*pi,17)
point(end)=[];
%ini = [2.0,1.0; 1.0,1.0; 1.0,2.0; 3.0,1.0];
%1.0, 3.0;2.0,2.0; 3.0,3.0];
[X,Y] = meshgrid(point,point);
ini = [cos(point(:)),sin(point(:))];
%ini = [cos(X(:)),sin(X(:))];
P = [sqrt(a/(a+b)),sqrt(a/(a+b)); sqrt(b/(a+b)),-sqrt(b/(a+b))];
xi_1 = P(:,1);
xi_2 = P(:,2);
P_1 = inv(P);
U = P_1 * ini';
%display(U);
u_0 = U(1);
v_0 = U(2);
%disp(model_1(ini))
x_star = zeros(2);

t = linspace(-2,2,200);
sol = @(t,u) u(1)*xi_1 .* exp(omega*t) + u(2)*xi_2 .* exp(-omega*t);
fig = figure();
subplot(1,2,1);hold on;
for k = 1:size(U,2)
  x = sol(t,U(:,k))(1,:);
  y = sol(t,U(:,k))(2,:);
  plot(x,y);
  %plot(x,y,'DisplayName',sprintf('initial = %.2f, %.2f',ini'(1,k),ini'(2,k)));
endfor
l1 = plot(t,sqrt(b/a)*t,'k','DisplayName',sprintf('Eigenline sqrt(b/a)=%.2f',sqrt(b/a)),'LineWidth',1.2);
l2 = plot(t,-sqrt(b/a)*t,'k','DisplayName',sprintf('Eigenline -sqrt(b/a)=%.2f',-sqrt(b/a)),'LineWidth',1.2);
x_n = plot(t,zeros(size(t)),'k');
y_n = plot(zeros(size(t)),t,'k');
vecs = linspace(-3,3,25);
[X,Y] = meshgrid(vecs);
U_ = A(1,1)*X + A(1,2)*Y;
V = A(2,1)*X + A(2,2)*Y;
L = hypot(U_,V);
U_ = U_./L;
V = V ./L;
quiver(X,Y,U_,V);
NX_U = A(1,1)*X;
NX_V = A(2,1)*X;
%NX_U = normalize_cols(NX_U);
%NX_V = normalize_cols(NX_V);
Y_N = zeros(size(Y));
L_X = hypot(NX_U,NX_V);
NX_U = NX_U./L_X
NX_V = NX_V./L_X
NX = quiver(X,Y_N,NX_U,NX_V,'DisplayName','x-nullcline','LineWidth',1.);
NY_U = A(1,2)*Y;
NY_V = A(2,2)*Y;
%NY_U = normalize_cols(NY_U);
%NY_V = normalize_cols(NY_V);
X_N = zeros(size(X));
L = hypot(NY_U,NY_V);
NY = quiver(X_N,Y,NY_U./L,NY_V./L,'DisplayName','y-nullcline','LineWidth',1.);
eq=plot(x_star(1),x_star(2),'o','MarkerSize',7,
'MarkerFaceColor','r','DisplayName',
sprintf('Equilibrium (%g, %g)',x_star(1),x_star(2)));
hold off;
xlim([-2,2]); ylim([-2,2]);
legend([l1,l2,NX,NY,eq]);
title(sprintf("Relational spending, a=%g, b=%g",a,b));
xlabel("Nation A");
ylabel("Nation B");
grid on;
axis on;
sample = randperm(size(U,2),7);
samples = U(:,sample);
subplot(1,2,2);
hold on;
for k=1:size(samples,2)
  traj = sol(t,samples(:,k));
  x = traj(1,:);
  y = traj(2,:);
  if k == 1
    plot(t, x, 'b-',  'LineWidth', 1., 'DisplayName', 'Nation A');
    plot(t, y, 'r--', 'LineWidth', 1.2, 'DisplayName', 'Nation B');
  else
    plot(t, x, 'b-',  'LineWidth', 1., 'HandleVisibility', 'off');
    plot(t, y, 'r--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
  endif
  %plot(t,x,'DisplayName','Nation A');
  %lot(t,y,'DisplayName','Nation B');
endfor
hold off;
%plot(t,x,'DisplayName','Nation A');
%plot(t,y,'DisplayName','Nation B');
xlabel('Time');
ylabel('Spending');
legend('show');
grid on;
%waitfor(gcf);
%hold off;
print('figures/model_1_curves.png', '-dpng', '-S2100,1300');


%vecs = linspace(-3,3,20);
%[X,Y] = meshgrid(vecs);
%U = A(1,1)*X + A(1,2)*Y;
%V = A(2,1)*X + A(2,2)*Y;
%quiver(X,Y,U,V);
%grid on;
