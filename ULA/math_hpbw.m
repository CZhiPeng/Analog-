%% 数学方法求解波束宽度，再和公式方法求解比较

clc;
clear;

% 定义常量和参数
Delta = 0.0001; % 步长
theta = -pi/2:Delta:pi/2;
theta0 = -30*pi/180; % 来波方向，MATLAB中三角函数需要弧度
antenna_num = 2:1:100;
tolerance = 0.01;
hpbw_theta = zeros(1, length(antenna_num)); % 事先分配好 hpbw_theta 数组

for i = 1:length(antenna_num)
    % 计算波束增益
    [Gain, ~] = ULA__(antenna_num(i), theta0);
    maxGain = max(Gain(:));
    
    % 输出此时的天线个数，以及最大增益的角度信息
    fprintf('天线数量: %d\n', antenna_num(i));
    [~, max_theta] = find(Gain == maxGain);
    fprintf('增益最大的列: %d\n', max_theta);
    fprintf('增益最大的 theta 方向: theta = %.2f°\n', theta(max_theta) * 180 / pi);

    % 求出增益为一半的值的索引值
    target_gain = maxGain / sqrt(2); % 功率的一半
    theta_3db = find(abs(Gain - target_gain) < tolerance * maxGain, 1);

    if ~isempty(theta_3db)
        % 波束宽度
        hpbw_theta(i) = abs((theta(theta_3db) * 180 / pi) - (theta(max_theta) * 180 / pi)) * 2;
        fprintf('波束宽度为 %.2f°\n', hpbw_theta(i));
        fprintf('--------------------\n');

    else % 防止没找到
        disp('phi_3db 和/或 theta_3db 没有搜索出来');
        hpbw_theta(i) = 0;
        fprintf('--------------------\n');
    end
end

% 绘制波束宽度随天线数量的变化曲线
plot(antenna_num, hpbw_theta, 'r')
xlabel('天线数量')
ylabel('波束宽度 (°)')
title('波束宽度与天线数量关系-两种方法比较')
hold on;
beta_half=(1/cos(theta0))*51*2./antenna_num;
plot(antenna_num,beta_half,'g')

% 添加图例
legend('数学方法', '公式法', 'Location', 'NorthEast') 

%legend 函数用于在 MATLAB 图形中添加图例，以便标识不同数据系列或曲线的含义。
%'数学方法' 和 '公式法' 是图例中显示的文本标签。
%'Location' 参数用于指定图例的位置。在此情况下，'NorthEast' 表示将图例放置在图形的右上角。