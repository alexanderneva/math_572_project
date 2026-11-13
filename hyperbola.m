a = 0.5;
b = 2;
A = [0,a;b,0];
%model_1 = @(v) A * v'
omega = sqrt(a*b);
point = linspace(0,2*pi,17)
%ini = [2.0,1.0; 1.0,1.0; 1.0,2.0; 3.0,1.0;
%1.0, 3.0;2.0,2.0; 3.0,3.0];
[X,Y] = meshgrid(point,point);
ini = [cos(X(:)),sin(Y(:))];
P = [sqrt(a/(a+b)),sqrt(a/(a+b)); sqrt(b/(a+b)),-sqrt(b/(a+b))];
xi_1 = P(:,1);
xi_2 = P(:,2);
P_1 = inv(P);
U = P_1 * ini';
%display(U);
u_0 = U(1);
v_0 = U(2);
%disp(model_1(ini))

t = linspace(-2,2,200);
sol = @(t,u) u(1)*xi_1 .* exp(omega*t) + u(2)*xi_2 .* exp(-omega*t);
fig = figure();
subplot(2,1,1);
hold on;
for k = 1:size(U,2)
  x = sol(t,U(:,k))(1,:);
  y = sol(t,U(:,k))(2,:);
  plot(x,y,'DisplayName',sprintf('initial = %.2f, %.2f',ini'(1,k),ini'(2,k)));
endfor
plot(t,sqrt(b/a)*t,'DisplayName',sprintf('Line of slope sqrt(b/a)%.2f',sqrt(b/a)),'LineWidth',1);
plot(t,-sqrt(b/a)*t,'LineWidth',1)
hold off;
xlim([-2,2]); ylim([-2,2]);
%legend('show');
title(sprintf("Relational spending, a=%g, b=%g",a,b));
xlabel("Nation A");
ylabel("Nation B");
grid on;
subplot(2,1,2);
hold on;
x = sol(t,U(:,1))(1,:);
y = sol(t,U(:,1))(2,:);
plot(t,x,'DisplayName','Nation A');
plot(t,y,'DisplayName','Nation B');
xlabel('Time');
ylabel('Spending');
legend('show');
grid on;
%%waitfor(gcf);
hold off;
print('figures/model_1_curves.png', '-dpng', '-S800,600');
