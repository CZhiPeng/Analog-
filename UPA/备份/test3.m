clc, clear, close all
%% 指定方向角度
theta0 = 60*pi/180;
phi0 = 30*pi/180;
d_lamda = 1/2; % 阵元间距d与波长lamda的关系
%% 离散化相位
Delta = 0.01;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;
%% 初始化增益矩阵
Gain = zeros(length(theta), length(phi));
%Gain_db = zeros(length(theta), length(phi));
%% 天线数量
antenna_num_x = [4, 8, 16];
antenna_num_y = [4, 8, 16];

tolerance = [0.005,0.02,0.02]; 
for i = 1:3
    %% 波束赋形向量,用于相位补偿
    w1 = exp(-1*1i*2*pi*d_lamda*(sin(theta0)*sin(phi0)).*(0:antenna_num_x(i)-1)');
    w2 = exp(-1*1i*2*pi*d_lamda*sin(theta0)*cos(phi0).*(0:antenna_num_y(i)-1)');
    w = kron(w1, w2);

    %% 导向矢量,发射波束增益
    for j = 1:length(theta)
        for k = 1:length(phi)
            a1 = exp(-1*1i*2*pi*d_lamda*(sin(theta(j))*sin(phi(k))).*(0:antenna_num_x(i)-1)'); % x轴导向矢量,a:antenna_num_x(i)*1
            a2 = exp(-1*1i*2*pi*d_lamda*sin(theta(j))*cos(phi(k)).*(0:antenna_num_y(i)-1)'); % y轴导向矢量,b:antenna_num_y(i)*1
            a = kron(a1, a2); % 整体导向矢量,b:(antenna_num_x(i)*antenna_num_y(i))*1
            Gain(j, k) = w' * a./(antenna_num_x(i)*antenna_num_y(i)); % 发射波束增益=w'*a,并且归一化
            Gain(j, k) = abs(Gain(j, k));
        end
    end
    %% 输出增益最大的方向(两种角度)
    maxGain = max(Gain(:));
    [max_theta, max_phi] = find(Gain == maxGain);  %max_phi和max_theta是最大增益时的两个角度
    
    %输出此时的天线个数，以及最大增益的角度信息
    disp(['天线数量 ', num2str(antenna_num_x(i)), 'x', num2str(antenna_num_y(i)), ':']);
    disp(['增益最大的行和列：','Row: ', num2str(max_theta), ', Column: ', num2str(max_phi)]);
    disp(['增益最大的方向： theta=', num2str(theta(max_theta)*180/pi), '°, phi=', num2str(phi(max_phi)*180/pi), '°']);


    %% 求出增益为一半的值的索引值
    target_gain = maxGain / sqrt(2); % 功率的一半
    % 遍历最大值所在行，找到数值减少一半的行
    phi_3db = 0;
    theta_3db=0;
    
    %固定行，搜列，列是phi。phi_3db为增益为一半的值的phi索引值
    for k = 1:length(phi)
        if abs(Gain(max_theta, k) - target_gain) < tolerance(i)*maxGain
            phi_3db = k;
        end
    end
    
    
    %固定列，搜行，行是theta。theta_3db为增益为一半的值的phi索引值
    for m = 1:length(theta)
        if abs(Gain(m, max_phi) - target_gain) < tolerance(i)*maxGain
            theta_3db = m;
        end
    end


    if phi_3db > 0 && theta_3db > 0
        % 波束宽度
        hpbw_phi=abs((phi(phi_3db)*180/pi)-(phi(max_phi)*180/pi))*2;
        hpbw_theta=abs((theta(theta_3db)*180/pi)-(theta(max_theta)*180/pi))*2;
        hpbw_theta_phi=sqrt(hpbw_phi*hpbw_theta);
    
    
        % 显示
        disp(['固定行，增益减少一半所在的列的坐标：','Row: ', num2str(max_theta), ', Column: ', num2str(phi_3db)]);
        disp(['theta=', num2str(theta(max_theta)*180/pi), '°, phi=', num2str(phi(phi_3db)*180/pi), '°']);
        disp(['phi上的波束变化宽度为', num2str(hpbw_phi) , '°']);
        
        disp(['固定列，增益减少一半所在的行的坐标：','Row: ', num2str(theta_3db), ', Column: ', num2str(max_phi)]);
        disp(['theta=', num2str(theta(theta_3db)*180/pi), '°, phi=', num2str(phi(max_phi)*180/pi), '°']);
        disp(['theta上的波束变化宽度为',  num2str(hpbw_theta), '°']);
        
        disp(['波束整体宽度为',  num2str(hpbw_theta_phi), '°']);
        fprintf('Line 1\n');

    else %防止没找到
        disp('phi_3db 和/或 theta_3db 没有搜索出来');
        fprintf('Line 1\n');
    end

end
