%tyre parameters
r=0.2;
k_t=1.5e5; %longitudinal stiffness
c=0.13;
mu_st = 0.8;
mu_dyn = 0.4;
k_r = 1e4; %no idea
S = 0.13*0.2;
k_tv = 4e4;
k_tu = 1.5e5;

%body parameters
M = 1000; %weight
w= 1.6;%wheel distance
a = 2;
b = 2.5;
h_gc = 0.15;
Jy = 500;
Jx = 300;
Jz = 600; %kg*m^2
ca = 0.5; %air resistance
ks = 40000;
cs = sqrt(2*ks*M);
%Jw = 80; %tire inertia



L=sqrt(a^2+w^2 /4); 
R=sqrt(b^2+w^2 /4);
alpha=atan(w/(2*b));
theta=atan(w/(2*a));

