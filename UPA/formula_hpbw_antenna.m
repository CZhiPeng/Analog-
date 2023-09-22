%波束宽度和天线数量的关系
clc, clear, close all

%% 定义常量和参数
% 指定方向角度
theta0 = 30*pi/180;
phi0 = 30*pi/180;


% 天线数量
antenna_num_x = 2 : 1 : 30;
antenna_num_y = 2 : 1 : 30;
hpbw_theta_phi_formula=zeros(1, length(antenna_num_x)); %波束宽度矩阵


%% 主程序,formula
for i = 1:length(antenna_num_x)
    hpbw_theta_phi_formula(i)=formula_hpbw(antenna_num_x(i),antenna_num_y(i),theta0,phi0);
end


%% 绘图
new_labels = cell(1, length(antenna_num_x)); % 创建一个新标签的单元格数组
for i = 1:length(antenna_num_x)
    new_labels{i} = ['\it', num2str(antenna_num_x(i)), 'x', num2str(antenna_num_y(i))];
end
plot(antenna_num_x,hpbw_theta_phi_formula);hold off;


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



