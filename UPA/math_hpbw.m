function [hpbw_theta_phi] = math_hpbw(antenna_num_x,antenna_num_y,Gain,tolerance,Delta)
%UNTITLED 此处显示有关此函数的摘要
%   根据天线增益求解波束宽度
%输出波束宽度，输入x轴和y轴天线的个数、增益(重要参数)、允许误差、以及离散化相位
% 离散化相位，Delta越小，越能找到半功率

%%初始化参数设置
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;
hpbw_theta_phi=0;
maxGain = max(Gain(:));

%求解最大增益对应的两个角度
[max_theta, max_phi] = find(Gain == maxGain);  

%输出此时的天线个数，以及最大增益的角度信息
disp(['天线数量 ', num2str(antenna_num_x), 'x', num2str(antenna_num_y), ':']);
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
        hpbw_theta_phi=hpbw_phi*hpbw_theta;
    
    
        % 显示
        disp(['固定行，增益减少一半所在的列的坐标：','Row: ', num2str(max_theta), ', Column: ', num2str(phi_3db)]);
        disp(['theta=', num2str(theta(max_theta)*180/pi), '°, phi=', num2str(phi(phi_3db)*180/pi), '°']);
        disp(['phi上的波束变化宽度为', num2str(hpbw_phi) , '°']);
        
        disp(['固定列，增益减少一半所在的行的坐标：','Row: ', num2str(theta_3db), ', Column: ', num2str(max_phi)]);
        disp(['theta=', num2str(theta(theta_3db)*180/pi), '°, phi=', num2str(phi(max_phi)*180/pi), '°']);
        disp(['theta上的波束变化宽度为',  num2str(hpbw_theta), '°']);
        
        disp(['波束整体宽度为',  num2str(hpbw_theta_phi), '°']);
        fprintf('--------------------\n');

    else %防止没找到
        disp('phi_3db 和/或 theta_3db 没有搜索出来');
        fprintf('--------------------\n');
    end

end


