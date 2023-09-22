clc, clear, close all
%波束宽度和波束指向的关系图像

%% 定义常量和参数
% 方向角度范围
Delta = 0.02;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;

theta0 = (10:5:90)*pi/180;
phi0 = 0*pi/180;
k=length(theta0);%k个指向

% 初始化增益矩阵
Gain = zeros(length(theta), length(phi));

% 天线数量
antenna_num_x = 5; % 固定天线个数
antenna_num_y = 5;
hpbw_theta_phi = zeros(1, k); % 波束宽度矩阵

% 允许误差，为了搜到半功率波束宽度
tolerance = 0.03;

%% 主程序
for i = 1:k
    % 
    Gain = UPA_Gain(antenna_num_x, antenna_num_y, theta0(i), phi0, Delta);
    hpbw = math_hpbw(antenna_num_x, antenna_num_y, Gain, tolerance, Delta);
    hpbw_theta_phi(i) = hpbw;
end

%% 绘图
figure;

% 天线数量 vs. 波束宽度
plot(theta0*180/pi, hpbw_theta_phi);
xlabel('天线指向');
ylabel('波束宽度 (°)');
title('波束宽度和波束指向的关系图像');

% 调整图形的外观
set(gca, 'FontSize', 8);
