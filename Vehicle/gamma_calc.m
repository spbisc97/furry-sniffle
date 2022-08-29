clear all
syms a b delta gamma gamma_front l delta_ R_rear R_front R

  l = a+b;
delta_ = tan(delta+atan(gamma_front));
R_rear = sqrt(l^2*(1+gamma^2)/(gamma-delta_)^2);
 R_front = sqrt((l/(gamma-delta_))^2+(gamma*l/(gamma-delta_)-l)^2);
eq = R == (sqrt(l^2*(1+gamma^2)/(gamma-delta_)^2) * a + sqrt((l/(gamma-delta_))^2+(gamma*l/(gamma-delta_)-l)^2) * b)/l;

eq = subs(eq, [l,  delta, gamma_front, a, b],[3,  0.2, -0.1, 1.5, 1.5])
% R == (sqrt(l^2*(1+gamma^2)/(gamma-delta_)^2) * a + sqrt((l/(gamma-delta_))^2+(gamma*l/(gamma-delta_)-l)^2) * b)/l;

value = solve(eq, gamma);
value = subs(value, R, 3)