clc, clear, close all
%波束宽度和波束指向的关系图像,用公式

%% 定义常量和参数
% 方向角度范围
Delta = 0.01;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;

theta0 = (0:1:80)*pi/180;
phi0 = (0:1:80)*pi/180;
k=length(theta0);%k个指向

% 初始化增益矩阵
Gain = zeros(length(theta), length(phi));

% 天线数量
antenna_num_x = [5,10,20]; % 固定天线个数
antenna_num_y = [5,10,20];
hpbw_theta_phi_formula = zeros(length(antenna_num_x), k); % 波束宽度矩阵


%% 主程序
for j=1:length(antenna_num_x)
    for i = 1:k
        hpbw = formula_hpbw(antenna_num_x(j), antenna_num_y(j), theta0(i), phi0(i));
        hpbw_theta_phi_formula(j,i) = hpbw;
    end
end

%% 绘图
figure;

% 天线数量 vs. 波束宽度
plot(theta0*180/pi, hpbw_theta_phi_formula(1,:));hold on;
plot(theta0*180/pi, hpbw_theta_phi_formula(2,:));
plot(theta0*180/pi, hpbw_theta_phi_formula(3,:));hold off;
xlabel('天线指向角度(方位角和俯仰角相同)');
ylabel('波束宽度 (°)');
title('波束宽度和波束指向的关系图像');
legend([num2str(antenna_num_x(1)),'x',num2str(antenna_num_y(1))],[num2str(antenna_num_x(2)),'x',num2str(antenna_num_y(2))],[num2str(antenna_num_x(3)),'x',num2str(antenna_num_y(3))])

