syms t gamma(t) gamma_dot(t)  v_eta_dot(t)  v_xi_dot(t) vgx(t) vgx_dot(t)...
    vgy(t) vgy_dot(t) w_z(t) w_z_dot(t) f_eta_FR(t) f_eta_FL(t) f_eta_RL(t) f_eta_RR(t) ...
     f_xi_FR(t) f_xi_FL(t) f_xi_RL(t) f_xi_RR(t)  delta(t) delta_tire(t)  Fz  w_y(t)  sigma(t) ...
       w_y_front(t) gamma_front(t);
syms v_xi_front(t) v_eta_front(t) v_xi(t) v_eta(t);

%L'IDEA E' QUELLA DI TROVARE UNA RELAZIONE FRA W_Y DELLE RUOTE POSTERIORI(INPUT), 
% DELTA DELLO STERZO (INPUT) E GAMMA_DOT DELLA RUOTA POSTERIORE DESTRA (IN QUESTO ESEMPIO,OUTPUT)
%DA COMPLETARE; INSERIRE QUI EQUAZIONI DI F_ETA_FL ECC... 


c = (Fz*r*12/(k_r*0.2))^(1/3);
S = c*0.2;
sigma=(v_xi-w_y*r)/v_xi;
sigma_front=(v_xi_front-w_y_front*r)/v_xi_front;
%gamma = Vc_eta/Vc_xi;
delta_tire = r*2*sqrt(k_tu^2*sigma^2+k_tv^2*gamma^2)/(c*mu_st*k_r),1;
delta_tire_front = r*2*sqrt(k_tu^2*sigma_front^2+k_tv^2*gamma_front^2)/(c*mu_st*k_r), 1;
%if delta_tire>1
%    delta_tire=1;
%end
f_xi_RR = -sign(v_xi-w_y*r)*mu_st*Fz*(6*abs(sigma)/(sqrt(sigma^2+gamma^2))*mu_dyn/mu_st*(0.5-1/3*delta_tire)*(delta_tire)^2+S*k_tu*c/(2*mu_st*Fz)*(delta_tire-1)^2*abs(sigma));
f_eta_RR = -sign(v_eta)*abs(mu_st*Fz*(6*gamma/(sqrt(sigma^2+gamma^2))*mu_dyn/mu_st*(0.5-1/3*delta_tire)*(delta_tire)^2+S*k_tv*c/(2*mu_st*Fz)*(delta_tire-1)^2*gamma));



f_xi_FL = -sign(v_xi_front-w_y_front*r)*mu_st*Fz*(6*abs(sigma_front)/(sqrt(sigma_front^2+gamma_front^2))*mu_dyn/mu_st*(0.5-1/3*delta_tire_front)*(delta_tire_front)^2+S*k_tu*c/(2*mu_st*Fz)*(delta_tire_front-1)^2*abs(sigma_front));
f_eta_FL = -sign(v_eta_front)*abs(mu_st*Fz*(6*gamma_front/(sqrt(sigma_front^2+gamma_front^2))*mu_dyn/mu_st*(0.5-1/3*delta_tire_front)*(delta_tire_front)^2+S*k_tv*c/(2*mu_st*Fz)*(delta_tire_front-1)^2*gamma_front));



w_z_dot = 1/Jz*(-(2*f_eta_RR)*b+(2*f_eta_FL)*a*cos(delta)+(2*f_eta_FL)*a*sin(delta));
vgx_dot = 1/M*(2*f_xi_RR+(2*f_xi_FL)*cos(delta)- (2*f_xi_FL)*sin(delta));
vgy_dot = 1/M*((2*f_eta_RR)+(2*f_eta_FL)*cos(delta)+(2*f_eta_FL)*sin(delta))-w_z*vgx;



v_xi = vgx+w_z*R*sin(alpha);
v_eta = vgy-w_z*R*cos(alpha);
v_xi_front = vgx*cos(delta)+vgy*sin(delta);
v_eta_front = -vgx*sin(delta)+vgy*cos(delta);
gamma = v_eta/v_xi;
gamma_dot = diff(gamma, t)

gamma_dot = subs(gamma_dot, [diff(vgy(t), t), diff(w_z(t), t), diff(vgx(t), t)], [vgy_dot, w_z_dot, vgx_dot])

gamma_dot = subs(gamma_dot, v_xi(t), 1)
