clc,clear,close all
%% 指定方向角度
theta0 = 20*pi/180;
phi0 = 0*pi/180;
d_lamda=1/2;%阵元间距d与波长lamda的关系
%% 离散化相位
Delta = 0.02;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;
%% 初始化增益矩阵
Gain = zeros(length(theta),length(phi));

%% 天线数量
antenna_num_x = [4,8,16];
antenna_num_y =[4,8,16];

for i = 1:3
%% 波束赋形向量,用于相位补偿
w1=exp(-1*1i*2*pi*d_lamda*(sin(theta0)*sin(phi0)).*(0:antenna_num_x(i)-1)');
w2=exp(-1*1i*2*pi*d_lamda*sin(theta0)*cos(phi0).*(0:antenna_num_y(i)-1)');
w=kron(w1,w2);


%% 导向矢量,发射波束增益，阵列在XOY平面
    for j = 1:length(theta)
        for k = 1:length(phi)
            a1=exp(-1*1i*2*pi*d_lamda*(sin(theta(j))*sin(phi(k))).*(0:antenna_num_x(i)-1)');%x轴导向矢量,a:antenna_num_x(i)*1
            a2=exp(-1*1i*2*pi*d_lamda*sin(theta(j))*cos(phi(k)).*(0:antenna_num_y(i)-1)');%y轴导向矢量,b:antenna_num_y(i)*1
            a=kron(a1,a2); %整体导向矢量,b:(antenna_num_x(i)*antenna_num_y(i))*1
            Gain(j, k) = w' * a./(antenna_num_x(i)*antenna_num_y(i)); %发射波束增益=w'*a,并且归一化
        end
    end

%% 命令行输出增益最大的方向(两种角度)
[a,b] = find(Gain==max(max(Gain)));
disp(['增益最大的方向：',...
    'theta=',num2str(theta(a)*180/pi),'°',...
    ', phi=',num2str(phi(b)*180/pi),'°']);

%% 绘图
figure('position',[10+(i-1)*550 220 500 500]);
[X,Y] = meshgrid(theta,phi);
Gain = abs(Gain); % 取增益的模值
surf(X*180/pi,Y*180/pi,Gain');
xlabel('\theta'); ylabel('\phi'); zlabel('Beam Gain');
title(['Nx=',num2str(antenna_num_x(i)),', Ny=',num2str(antenna_num_y(i)),...
    ', \phi=',num2str(phi0*180/pi),'\circ',...
    ', \theta=',num2str(theta0*180/pi),'\circ']);
end






