%波束宽度和天线数量的关系
clc, clear, close all

%% 定义常量和参数
% 指定方向角度
theta0 = 30*pi/180;
phi0 = 30*pi/180;

% 离散化相位，Delta越小，越能找到半功率
Delta = 0.01;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;

% 初始化增益矩阵
Gain = zeros(length(theta), length(phi));

% 天线数量
antenna_num_x = 2 : 1 : 30;
antenna_num_y = 2 : 1 : 30;
hpbw_theta_phi=zeros(1, length(antenna_num_x)); %波束宽度矩阵

% 允许误差，为了搜到半功率波束宽度
tolerance = 0.03;

%% 主程序
for i = 1:length(antenna_num_x)
    Gain=UPA_Gain(antenna_num_x(i),antenna_num_y(i),theta0,phi0,Delta);%UPA_Gain是波束增益函数
    hpbw_theta_phi(i)=math_hpbw(antenna_num_x(i),antenna_num_y(i),Gain,tolerance,Delta);%math_hpbw是求解波束宽度函数

    if antenna_num_x(i)==20
    tolerance = 0.08;
    end
end

%% 绘图
new_labels = cell(1, length(antenna_num_x)); % 创建一个新标签的单元格数组
for i = 1:length(antenna_num_x)
    new_labels{i} = ['\it', num2str(antenna_num_x(i)), 'x', num2str(antenna_num_y(i))];
end
plot(antenna_num_x,hpbw_theta_phi);

% 设置横坐标刻度和标签
set(gca, 'XTick', antenna_num_x); % 设置刻度
set(gca, 'XTickLabel', new_labels); % 设置标签

% 缩小横坐标标签字体
xtickangle(90); % 旋转标签，以便更好地容纳标签
set(gca, 'FontSize', 8); % 设置坐标轴字体大小为10

% 添加标题和标签
xlabel('UPA阵列天线数量')
ylabel('两种角度综合波束宽度 (°)')
title('UPA天线数量和波束宽度的关系');



