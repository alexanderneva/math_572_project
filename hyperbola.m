t = linspace(0,1);
a = 1;
b = 2;
omega = sqrt(a*b);
initial = [2,1];
P = [sqrt(a/(a+b)),sqrt(a/(a+b)); sqrt(b/(a+b)),-sqrt(b/(a+b))];
xi_1 = P(:,1);
xi_2 = P(:,2);
disp(xi_1);
disp(xi_2);
P_1 = inv(P);
U = P_1 * initial';
u_0 = U(1);
v_0 = U(2);
disp(P_1);
disp(u_0);

sol = @(t) u_0*xi_1 .* exp(omega*t) + v_0*xi_2 .* exp(-omega*t);

fig = figure();
subplot(2,1,1)
x = sol(t)(1,:);
y = sol(t)(2,:);
plot(x,y);
title("Relation spending, {a} {b}");
xlabel("Nation A");
ylabel("Nation B");
grid on;
subplot(2,1,2);
hold on;
plot(t,x,'DisplayName','Nation A');
plot(t,y,'DisplayName','Nation B');
xlabel('Time');
ylabel('Spending');
legend('show');
grid on;
hold off;
