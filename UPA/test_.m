%比较
theta0 = 30*pi/180;
phi0 = 30*pi/180;

% 离散化相位，Delta越小，越能找到半功率
Delta = 0.005;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;

tolerance = 0.01;

antenna_num_x = 10 ;
antenna_num_y = 10 ;

Gain=UPA_Gain(antenna_num_x,antenna_num_y,theta0,phi0,Delta);

hpbw_theta_phi_math=math_hpbw(antenna_num_x,antenna_num_y,Gain,tolerance,Delta);

d_lamda=1/2; 
beta_half_x=51*(d_lamda)./antenna_num_x;
beta_half_y=51*(d_lamda)./antenna_num_y;
k_theta=(beta_half_x)^(-2)*(cos(phi0))^2+(beta_half_y)^(-2)*(sin(phi0))^2;
k_phi=(beta_half_x)^(-2)*(sin(phi0)^2)+(beta_half_y)^(-2)*(cos(phi0)^2);
hpbw_theta=1/(cos(theta0)*sqrt(k_theta));
hpbw_phi=sqrt(1/k_phi);