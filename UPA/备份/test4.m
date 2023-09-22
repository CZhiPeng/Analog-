clc, clear, close all

%% 定义常量和参数
% ...（之前的代码保持不变）

% 创建一个数组来存储波束宽度值
hpbw_theta_phi = zeros(1, length(antenna_num_x));

%% 主程序
for i = 1:length(antenna_num_x)
    % ...（之前的代码保持不变）

    if phi_3db > 0 && theta_3db > 0
        % 波束宽度
        hpbw_phi = abs((phi(phi_3db) * 180 / pi) - (phi(max_phi) * 180 / pi)) * 2;
        hpbw_theta = abs((theta(theta_3db) * 180 / pi) - (theta(max_theta) * 180 / pi)) * 2;
        hpbw_theta_phi(i) = sqrt(hpbw_phi * hpbw_theta);

        % ...（之前的代码保持不变）
    else
        % ...（之前的代码保持不变）
    end
end

% 绘图
new_labels = cell(1, length(antenna_num_x));

for i = 1:length(antenna_num_x)
    new_labels{i} = ['\it', num2str(antenna_num_x(i)), 'x', num2str(antenna_num_y(i))];
end

figure; % 创建新的图形窗口
plot(antenna_num_x, hpbw_theta_phi);

% 设置横坐标刻度和标签
set(gca, 'XTick', antenna_num_x);
set(gca, 'XTickLabel', new_labels);

% 缩小横坐标标签字体
xtickangle(90);
set(gca, 'FontSize', 10);

% 添加标题和标签
xlabel('天线数量')
ylabel('整体波束宽度 (°)')
title('天线数量和波束宽度的关系');
