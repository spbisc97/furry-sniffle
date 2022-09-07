clear all
%% tyre parameters
r=0.3;%wheel radius
k_t=1.5e5; %longitudinal stiffness

mu_st = 0.8;%static tire-road friction coefficient
mu_dyn = 0.2;% dynamic tire-road friction coefficient
k_r = 200*1e4;%1e4; %no idea
k_tv = 10*40000;%Lateral tire stiffness [N/rad]
k_tu = 10*1.5e5;%Longitudinal tire stiffness [N]

%% body parameters
M = 1500; %weight
w= 1.6;%wheel distance
a = 1.3;%distance btw CoG and front;
b = 1.8;% distance btw CoG and rear
h_gc = 0.35;%height CoG
Jy = 500;%kg*m^2
Jx = 300;%kg*m^2
Jz = 600; %kg*m^2
ca = 0.5; %air resistance
ks = 39000/4;
cs = sqrt(2*ks*M);
J_wheel = 0.4;

L=sqrt(a^2+w^2 /4); %distance between CoG and front wheel 
R=sqrt(b^2+w^2 /4);%distance between CoG and rear wheel
alpha=atan(w/(2*b));%[rad]
theta=atan(w/(2*a));%[rad]


%% engine parameters
K_motore = 1;
R_motore = 0.210;
L_motore = 0.001100;
K_elettrica_motore = 0.1;
J_motore = 0.3;
K_f_motore = 1;

