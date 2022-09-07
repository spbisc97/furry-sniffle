

% Parameters
Velocity=10;   	% Vehicle speed [m/s]
dt=0.01;        % sample time [s]
q=2;            % road class number [3 - 9] 
length_road=2000; % [m]
delta_road=0.05; % [m] 

%------------------------------------------------------------------------------------
% Road generator
%------------------------------------------------------------------------------------
gn0=2*pi*2*2^(2*q-2)*10^-6;
n_0=0.1;                % [cicli/m];
n_max=1/delta_road;     %  n = 1/lambda  [cycles/m]
delta_n=1/length_road; 
N=n_max/delta_n;        % number of harmonics making up the profile to be generated
t_end=length_road/Velocity;                   
t=(0:dt:t_end);         % time vector                  
phase=random('Normal',0,2*pi,N,1);   % random phase
road=zeros(1,length(t));
n=delta_n:delta_n:n_max;
i=0;
for n_i=n
    i=i+1;
    road =   road+sqrt(2*(gn0*(n_i/n_0).^-2)*delta_n).*cos(2*pi*n_i*Velocity*t+phase(i));
end 

figure 
plot(t,road)
grid on
xlabel('t [s]')
ylabel('road [m]')

road_input=[t; road-road(1)]';

