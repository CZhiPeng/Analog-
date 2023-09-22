%%极化分辨率和波束分辨率的关系图
%upa阵列规模32x32
clc;
clear;

theta0 = 30*pi/180;
phi0 = 30*pi/180;

antenna_num_x_16= 16; %固定x轴的天线个数，以便分割之后两个阵列依旧是矩阵阵列
antenna_num_x_32= 32; %固定x轴的天线个数，以便分割之后两个阵列依旧是矩阵阵列
antenna_num_x_64= 64; %固定x轴的天线个数，以便分割之后两个阵列依旧是矩阵阵列

antenna_num_y_total_16=16;
antenna_num_y_total_32=32;
antenna_num_y_total_64=64;

hpbw_theta_phi_formula_h_16=zeros(1, length(antenna_num_y_total_16)-1);
hpbw_theta_phi_formula_v_16=zeros(1, length(antenna_num_y_total_16)-1);
hpbw_theta_phi_formula_h_32=zeros(1, length(antenna_num_y_total_32)-1);
hpbw_theta_phi_formula_v_32=zeros(1, length(antenna_num_y_total_32)-1);
hpbw_theta_phi_formula_h_64=zeros(1, length(antenna_num_y_total_64)-1);
hpbw_theta_phi_formula_v_64=zeros(1, length(antenna_num_y_total_64)-1);

%求解波束宽度
for i = 1:antenna_num_y_total_16-1
    hpbw_theta_phi_formula_h_16(i)=formula_hpbw(antenna_num_x_16,i,theta0,phi0);
    hpbw_theta_phi_formula_v_16(i)=formula_hpbw(antenna_num_x_16,antenna_num_y_total_16-i,theta0,phi0);

end

%求解波束宽度
for i = 1:antenna_num_y_total_32-1
    hpbw_theta_phi_formula_h_32(i)=formula_hpbw(antenna_num_x_32,i,theta0,phi0);
    hpbw_theta_phi_formula_v_32(i)=formula_hpbw(antenna_num_x_32,antenna_num_y_total_32-i,theta0,phi0);

end

%求解波束宽度
for i = 1:antenna_num_y_total_64-1
    hpbw_theta_phi_formula_h_64(i)=formula_hpbw(antenna_num_x_64,i,theta0,phi0);
    hpbw_theta_phi_formula_v_64(i)=formula_hpbw(antenna_num_x_64,antenna_num_y_total_64-i,theta0,phi0);

end

% plot(hpbw_theta_phi_formula_v_16,hpbw_theta_phi_formula_h_16);hold on;
% plot(hpbw_theta_phi_formula_v_32,hpbw_theta_phi_formula_h_32);
plot(hpbw_theta_phi_formula_v_64,hpbw_theta_phi_formula_h_64);hold off;
title('V极化方向上天线数量减少，H极化方向上天线增加');
xlabel('V极化波束宽度(°)');
ylabel('H极化波束宽度(°)');
%legend([num2str(antenna_num_x_16),'x',num2str(antenna_num_y_total_16)])
%legend([num2str(antenna_num_x_16),'x',num2str(antenna_num_y_total_16)],[num2str(antenna_num_x_32),'x',num2str(antenna_num_y_total_32)],[num2str(antenna_num_x_64),'x',num2str(antenna_num_y_total_64)])
legend([num2str(antenna_num_x_64),'x',num2str(antenna_num_y_total_64)])

%k=formula_hpbw(16,2,theta0,phi0);