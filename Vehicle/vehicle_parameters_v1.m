clear all
%tyre parameters
r=0.3;
k_t=1.5e5; %longitudinal stiffness
%c=0.2;%0.13;
mu_st = 0.8;
mu_dyn = 0.2;
k_r = 200*1e4;%1e4; %no idea
%S = 0.2*c;
k_tv = 10*40000;%400;%4e4;
k_tu = 10*1.5e5;%1500;%1.5e5;

%body parameters
M = 1000; %weight
w= 1.6;%wheel distance
a = 1.3;%2;
b = 1.8;%2.5
h_gc = 0.15;
Jy = 500;
Jx = 300;
Jz = 600; %kg*m^2
ca = 0.5; %air resistance
ks = 40000;
cs = sqrt(2*ks*M);
%Jw = 80; %tire inertia
J_wheel = 0.4;




L=sqrt(a^2+w^2 /4); 
R=sqrt(b^2+w^2 /4);
alpha=atan(w/(2*b));
theta=atan(w/(2*a));


%parametri motore (a caso per ora, ma altrimenti non posso far girare la simulazione)
K_motore = 1;
R_motore = 0.210;
L_motore = 0.001100;
K_elettrica_motore = 0.1;
J_motore = 0.3;
K_f_motore = 1;

