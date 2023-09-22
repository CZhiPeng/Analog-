%%极化分辨率和波束分辨率的关系图
clc;
clear;
lamda=0.03;          %波长为0.03米
d=1/2*lamda;        %阵元间距与波长的关系
theta0=0;%来波方向
antenna_num = 128;

% 初始化空数组
antenna_num_h = [];
antenna_num_h = [];
beta_half_h = [];
beta_half_h = [];
j=1;

%求分辨率
for i = 3:120
    antenna_num_h(j) = i;
    antenna_num_v(j) =antenna_num-antenna_num_h(j);
    beta_half_h(j)=(1/cos(theta0))*51*(lamda/d)/antenna_num_h(j);
    beta_half_v(j)=(1/cos(theta0))*51*(lamda/d)/antenna_num_v(j);
    j=j+1;
end

%画图,横坐标应该是波束分辨率,随着天线的减少，波束宽度变宽，波束分辨率降低；纵坐标应该是极化分辨率，随着天线数量的增加，波束宽度变窄，极化分辨率增加
plot(beta_half_v,beta_half_h,'r')
title('天线总数不变，V极化方向上天线数量减少，H极化方向上天线增加');
xlabel('V极化波束宽度(°)');
ylabel('H极化波束宽度(°)');

