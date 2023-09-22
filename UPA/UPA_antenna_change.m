clc,clear,close all
%% 指定方向角度
theta0 = 20*pi/180;
phi0 = 20*pi/180;
d_lamda=1/2;%阵元间距d与波长lamda的关系
%% 离散化相位
Delta = 0.02;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;
%% 初始化增益矩阵
Gain = zeros(length(theta),length(phi));

%% 天线数量
antenna_num_x = [4,8,16,64];
antenna_num_y =[4,8,16,64];

%% 三种天线规模的发射波束增益

for i = 1:length(antenna_num_x)
    Gain=UPA_Gain(antenna_num_x(i),antenna_num_y(i),theta0,phi0,Delta);

%% 命令行输出增益最大的方向(两种角度)
[a,b] = find(Gain==max(max(Gain)));
disp(['增益最大的方向：',...
    'theta=',num2str(theta(a)*180/pi),'°',...
    ', phi=',num2str(phi(b)*180/pi),'°']);

%% 绘图
figure('position',[10+(i-1)*550 220 500 500]);
[X,Y] = meshgrid(theta,phi);
surf(X*180/pi,Y*180/pi,Gain');
xlabel('\theta'); ylabel('\phi'); zlabel('Beam Gain');
title(['Nx=',num2str(antenna_num_x(i)),', Ny=',num2str(antenna_num_y(i)),...
    ', \phi=',num2str(phi0*180/pi),'\circ',...
    ', \theta=',num2str(theta0*180/pi),'\circ']);
end






