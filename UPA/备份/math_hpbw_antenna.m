%波束宽度和天线数量的关系
clc, clear, close all

%% 定义常量和参数
% 指定方向角度
theta0 = 30*pi/180;
phi0 = 30*pi/180;
d_lamda = 1/2; % 阵元间距d与波长lamda的关系

% 离散化相位，Delta越小，越能找到半功率
Delta = 0.05;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;

% 初始化增益矩阵
Gain = zeros(length(theta), length(phi));

% 天线数量
antenna_num_x = 2 : 1 : 30;
antenna_num_y = 2 : 1 : 30;
hpbw_theta_phi=zeros(1, length(antenna_num_x)); %整体波束宽度

% 允许误差，为了搜到半功率波束宽度
tolerance = 0.03;

%% 主程序
for i = 1:length(antenna_num_x)
    Gain=UPA_Gain(antenna_num_x(i),antenna_num_y(i),theta0,phi0);%波束增益

    % 输出增益最大的方向(用俯仰角和方位角表示)
    maxGain = max(Gain(:));
    [max_theta, max_phi] = find(Gain == maxGain);  %max_phi和max_theta是最大增益时的两个角度
    
    %输出此时的天线个数，以及最大增益的角度信息
    disp(['天线数量 ', num2str(antenna_num_x(i)), 'x', num2str(antenna_num_y(i)), ':']);
    disp(['增益最大的行和列：','Row: ', num2str(max_theta), ', Column: ', num2str(max_phi)]);
    disp(['增益最大的方向： theta=', num2str(theta(max_theta)*180/pi), '°, phi=', num2str(phi(max_phi)*180/pi), '°']);


    %% 求出增益为一半的值的索引值
    target_gain = maxGain / sqrt(2); % 功率的一半

    % phi_3db和theta_3db要求的，是索引值
    phi_3db = 0;
    theta_3db=0;
    
    %固定行，搜列，列是phi。phi_3db为增益为一半的值的phi索引值
    for k = 1:length(phi)
        if abs(Gain(max_theta, k) - target_gain) < tolerance*maxGain
            phi_3db = k;
            break; % 在满足条件时跳出 for 循环
        end
    end
    
    
    %固定列，搜行，行是theta。theta_3db为增益为一半的值的phi索引值
    for m = 1:length(theta)
        if abs(Gain(m, max_phi) - target_gain) < tolerance*maxGain
            theta_3db = m;
            break; % 在满足条件时跳出 for 循环
        end
    end


    if phi_3db > 0 && theta_3db > 0
        % 波束宽度
        hpbw_phi=abs((phi(phi_3db)*180/pi)-(phi(max_phi)*180/pi))*2;
        hpbw_theta=abs((theta(theta_3db)*180/pi)-(theta(max_theta)*180/pi))*2;
        hpbw_theta_phi(i)=sqrt(hpbw_phi*hpbw_theta);
    
    
        % 显示
        disp(['固定行，增益减少一半所在的列的坐标：','Row: ', num2str(max_theta), ', Column: ', num2str(phi_3db)]);
        disp(['theta=', num2str(theta(max_theta)*180/pi), '°, phi=', num2str(phi(phi_3db)*180/pi), '°']);
        disp(['phi上的波束变化宽度为', num2str(hpbw_phi) , '°']);
        
        disp(['固定列，增益减少一半所在的行的坐标：','Row: ', num2str(theta_3db), ', Column: ', num2str(max_phi)]);
        disp(['theta=', num2str(theta(theta_3db)*180/pi), '°, phi=', num2str(phi(max_phi)*180/pi), '°']);
        disp(['theta上的波束变化宽度为',  num2str(hpbw_theta), '°']);
        
        disp(['波束整体宽度为',  num2str(hpbw_theta_phi(i)), '°']);
        fprintf('--------------------\n');

    else %防止没找到
        disp('phi_3db 和/或 theta_3db 没有搜索出来');
        fprintf('--------------------\n');
    end

    if antenna_num_x(i)==20
    tolerance = 0.08;
    end
end
%绘图
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
set(gca, 'FontSize', 10); % 设置坐标轴字体大小为10

% 添加标题和标签
xlabel('天线数量')
ylabel('整体波束宽度 (°)')
title('天线数量和波束宽度的关系');



