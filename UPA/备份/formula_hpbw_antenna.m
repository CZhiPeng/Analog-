%%输入指向方向(theta0，phi0)、横坐标M阵元的半功率波束宽度beta_half_x、纵坐标N阵元的半功率波束宽度beta_half_y
%% 参数初始化
theta0 = 30*pi/180;
phi0 = 30*pi/180;

% 离散化相位，Delta越小，越能找到半功率
Delta = 0.01;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;
d_lamda=1/2; 
hpbw_theta_phi=[];
%横坐标M阵元的半功率波束宽度beta_half_x、纵坐标N阵元的半功率波束宽度beta_half_y
% beta_half_x=51*(d_lamda)./antenna_num_x;
% beta_half_y=51*(d_lamda)./antenna_num_y;

%俯仰角的半功率波束宽度hpbw_theta
%方位角的半功率波束宽度hpbw_phi
% k_theta=(beta_half_x)^(-2)*(cos(phi0))^2+(beta_half_y)^(-2)*(sin(phi0))^2;
% k_phi=(beta_half_x)^(-2)*(sin(phi0)^2)+(beta_half_y)^(-2)*(cos(phi0)^2);
% hpbw_theta=1/(cos(theta0)*sqrt(k_theta));
% hpbw_phi=sqrt(1/k_phi);
% hpbw_theta_phi=hpbw_theta*hpbw_phi;

antenna_num_x = 1 : 1 : 30;
antenna_num_y = 1 : 1 : 30;

for i = 1:length(antenna_num_x)
    beta_half_x=51*(d_lamda)./antenna_num_x(i);
    beta_half_y=51*(d_lamda)./antenna_num_y(i);
    k_theta=(beta_half_x)^(-2)*(cos(phi0))^2+(beta_half_y)^(-2)*(sin(phi0))^2;
    k_phi=(beta_half_x)^(-2)*(sin(phi0)^2)+(beta_half_y)^(-2)*(cos(phi0)^2);
    hpbw_theta=1/(cos(theta0)*sqrt(k_theta));
    hpbw_phi=sqrt(1/k_phi);
    hpbw_theta_phi(i)=sqrt(hpbw_theta*hpbw_phi);

end
plot(hpbw_theta_phi);




