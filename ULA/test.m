clc;
clear;
lamda = 0.03;          % 波长为0.03米
d = 1/2 * lamda;        % 阵元间距与波长的关系
theta0 = (0:0.5:90) * pi/180;   % 来波方向，Matlab中三角函数需要弧度
antenna_nums = [16, 32, 64];    % 不同阵元数

beta_half = zeros(length(antenna_nums), length(theta0));  % 存储不同阵元数下的波束宽度

for i = 1:length(antenna_nums)
    antenna_num = antenna_nums(i);
    beta_half(i, :) = (1./cos(theta0)) * (2.*asin(0.88./(antenna_num.*sin(theta0)))) * (180/pi);
end

for i = 1:length(antenna_nums)
    plot(theta0*180/pi, beta_half(i, :), 'DisplayName', [num2str(antenna_nums(i)), '阵元']);
    hold on;
end
hold off;

xlabel('角度°')
ylabel('波束宽度（°）')
legend('Location', 'Best');
