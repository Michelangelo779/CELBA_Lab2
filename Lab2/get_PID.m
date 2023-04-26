Bequ=1.2287e-06;
Tsf=0.0057;
w_ci=2*pi*20; % filters
delta_i=1/sqrt(2); %filters
Requ=mot.R+sens.curr.Rs;
Jequ=4.8750e-07;
km = (drv.dcgain*mot.Kt)/(Requ*Bequ + mot.Kt*mot.Ke);
Tm = (Requ)*(Jequ)/(Requ*Bequ+mot.Kt*mot.Ke);
num = [km];
den = [Tm*gbox.N gbox.N 0];
P = tf(num, den)

% bodeplot(P)
% w_crossing=33.8321; % original w_crossing
% delta=0.5912;       % original delta
w_crossing=33.8321;
delta=0.5912;
phase_margin=atan(2*delta/(sqrt((sqrt(1+4*(delta^4))-2*(delta^2)))));
[mod_P,phase] = bode(P,w_crossing);
phase_P = phase/180 * pi;
delta_phi = -pi + phase_margin - phase_P;
delta_k = 1/mod_P;
alpha = 4000;
Kp = delta_k*cos(delta_phi)
Td = (tan(delta_phi)+sqrt(tan(delta_phi)^2+4/alpha))/(2*w_crossing);
Ti = alpha*Td;
Kd = Kp*Td
Ki = Kp/Ti
% Ki=-w_crossing*delta_k*sin(delta_phi)
%Kp=8 Ki=40 Kd=12
%ki=Kp=3 %%seconda versione
% terza versione w=50 phase_m=+1.3