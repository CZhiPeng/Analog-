function [A_theta,A_theta_dB] = ULA__(antenna_num,theta0)
%ULA__ 此处显示有关此函数的摘要
%   ULA阵列函数，输入天线个数，输出方向图幅度(电场幅值)
 
d_lamda=1/2;%阵元间距d与波长lamda的关系
Delta = 0.0001; % 步长
theta = -pi/2:Delta:pi/2;

%% 初始化增益矩阵
Gain =zeros(1,length(theta)); 

%% 波束赋形向量,用于相位补偿
w=exp(1i*2*pi*d_lamda*sin(theta0).*(0:antenna_num-1)'); 

%% 导向矢量,发射波束增益
for  j=1:length(theta)
     a=exp(-1*1i*2*pi*d_lamda*sin(theta(j)).*(0:antenna_num-1)');%导向矢量
     Gain(j)=w'*a;
end
%% 方向图
A_theta = abs(Gain); %幅度方向图
% %A_theta_dB = db(abs(sum(p,1))/max(abs(sum(p,1))));%归一化
A_theta_dB = db(abs(sum(Gain,1))); %增益，没有归一化


