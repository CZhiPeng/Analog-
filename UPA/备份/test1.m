clc, clear, close all
%% 指定方向角度
theta0 = 20*pi/180;
phi0 = 30*pi/180;
d_lamda = 1/2; % 阵元间距d与波长lamda的关系
%% 离散化相位
Delta = 0.04;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;
%% 初始化增益矩阵
Gain = zeros(length(theta), length(phi));
%Gain_db = zeros(length(theta), length(phi));
%% 天线数量
antenna_num_x = [4, 8, 16];
antenna_num_y = [4, 8, 16];

for i = 1:1
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
            %Gain(j, k) = w' * a;
        end
    end
    %% 输出增益最大的方向(两种角度)
    maxGain = max(Gain(:));
    [a, b] = find(Gain == maxGain);
    disp(['增益最大的方向：',...
        'theta=', num2str(theta(a)*180/pi), '°',...
        ', phi=', num2str(phi(b)*180/pi), '°',...
        'Row: ', num2str(a), ', Column: ', num2str(b)]);

    %% 找到最接近增益一半的值
    target_gain = maxGain/sqrt(2); % 功率的一半
    tolerance = 1; % 容忍的误差,1°
    
    % 横线功率减少一半的行和列
    [c1, d1] = find(abs(Gain(a,:) - target_gain) < tolerance);
    disp('横线功率减少一半的行和列：');
    for idx = 1:length(c1)
        disp(['Row: ', num2str(c1(idx)), ', Column: ', num2str(d1(idx))]);
    end


    
    %纵线功率减少一半的行和列
     [c2, d2] = find(abs(Gain(:,b) - target_gain) < tolerance);
    disp('纵线减少3db的行和列：');
    for idx = 1:length(c2)
        disp(['Row: ', num2str(c2(idx)), ', Column: ', num2str(d2(idx))]);
    end
%     % 找到最接近的增益一半的行和列的具体数值
%     closest_half_gain_values = Gain(c, d);
%     disp('对应的增益一半的数值：');
%     disp(closest_half_gain_values);

end
