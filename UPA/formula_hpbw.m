function [hpbw_theta_phi] = formula_hpbw(antenna_num_x,antenna_num_y,theta0,phi0)
%FORMULA_HPBW_ANTENNA 此处显示有关此函数的摘要
%   此处显示详细说明
%%输入指向方向(theta0，phi0)、横坐标M阵元的半功率波束宽度beta_half_x、纵坐标N阵元的半功率波束宽度beta_half_y
d_lamda=1/2; 

%横坐标M阵元的半功率波束宽度beta_half_x、纵坐标N阵元的半功率波束宽度beta_half_y
beta_half_x=51*(d_lamda)./antenna_num_x;
beta_half_y=51*(d_lamda)./antenna_num_y;

%俯仰角的半功率波束宽度hpbw_theta
%方位角的半功率波束宽度hpbw_phi
k_theta=(beta_half_x)^(-2)*(cos(phi0))^2+(beta_half_y)^(-2)*(sin(phi0))^2;
k_phi=(beta_half_x)^(-2)*(sin(phi0)^2)+(beta_half_y)^(-2)*(cos(phi0)^2);
hpbw_theta=1/(cos(theta0)*sqrt(k_theta));
hpbw_phi=sqrt(1/k_phi);
% hpbw_theta=beta_half_x/cos(theta0);
% hpbw_phi=beta_half_x;
%hpbw_theta_phi=sqrt(hpbw_theta*hpbw_phi);
hpbw_theta_phi=hpbw_theta*hpbw_phi;

end

