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

tolerance = [0.005,0.01,0.02]; 
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
            Gain(j, k) = abs(Gain(j, k));
        end
    end
%% 输出增益最大的方向(两种角度)
maxGain = max(Gain(:));
[a, b] = find(Gain == maxGain);

disp(['天线数量 ', num2str(antenna_num_x(i)), 'x', num2str(antenna_num_y(i)), ':']);
disp(['增益最大的方向： theta=', num2str(theta(a)*180/pi), '°, phi=', num2str(phi(b)*180/pi), '°']);
disp(['增益最大的行和列：','Row: ', num2str(a), ', Column: ', num2str(b)]);


%% 找到最接近增益一半的值
target_gain = maxGain / sqrt(2); % 功率的一半

% 遍历最大值所在行，找到数值减少一半的行
c1 = a;
d1 = [];
d2=[];
%搜行
for k = 1:length(phi)
    if abs(Gain(a, k) - target_gain) < tolerance(i)*maxGain
        d1 = [d1, k];
    end
end
    for idx = 1:length(d1)
        disp(['Row: ', num2str(a), ', Column: ', num2str(d1(idx))]);
        disp(['theta=', num2str(theta(a)*180/pi), '°, phi=', num2str(phi(d1(idx))*180/pi), '°']);
    end
  %搜列
for m = 1:length(theta)
    if abs(Gain(m, b) - target_gain) < tolerance(i)*maxGain
        d2 = [d2, m];
    end
end
    for idy = 1:length(d2)
        disp(['Row: ', num2str(d2(idy)), ', Column: ', num2str(b)]);
        disp(['theta=', num2str(theta(d2(idy))*180/pi), '°, phi=', num2str(phi(b)*180/pi), '°']);
    end
% 
% % 遍历最大值所在列，找到数值减少一半的列
% c2 = [];
% d2 = b;
% for j = 1:length(theta)
%     if abs(Gain(j, b) - target_gain) < tolerance
%         c2 = [c2, j];
%     end
% end

% disp('横线功率减少一半的行和列：');
% for idx = 1:length(c1)
%     disp(['Row: ', num2str(c1(idx)), ', Column: ', num2str(d1(idx))]);
% end
% 
% 
% disp('纵线功率减少一半的行和列：');
% for idx = 1:length(c2)
%     disp(['Row: ', num2str(c2(idx)), ', Column: ', num2str(d2(idx))]);
% end

%     % 找到最接近的增益一半的行和列的具体数值
%     closest_half_gain_values = Gain(c, d);
%     disp('对应的增益一半的数值：');
%     disp(closest_half_gain_values);

end
