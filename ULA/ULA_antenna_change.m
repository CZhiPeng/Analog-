%多阵元均匀线阵方向图，来波方向为0度
clc;
clear;
theta=linspace(-pi/2,pi/2,1000);
theta0=0;%来波方向
antenna_num1=16;     %阵元数
antenna_num2=32; 
antenna_num3=64;
[A_theta_16,A_theta_dB_16] = ULA__(antenna_num1,theta0);
[A_theta_32,A_theta_dB_32] = ULA__(antenna_num2,theta0);
[A_theta_64,A_theta_dB_64] = ULA__(antenna_num3,theta0);

%% 天线个数改变，方向图幅度(电场幅值)变化
figure(1);
plot(theta,A_theta_16);grid on ;hold on;
plot(theta,A_theta_32);hold on;
plot(theta,A_theta_64);hold off

xlabel('theta/radian')
ylabel('amplitude')
title('多种阵元均匀线阵方向图')
legend([num2str(antenna_num1),'阵元'],[num2str(antenna_num2),'阵元'],[num2str(antenna_num3),'阵元'])

%% 将16阵元归一化，其余没有归一化
figure(2);
% plot(theta,A_theta_dB_16),grid on;hold on;
% plot(theta,A_theta_dB_32);hold on;
% plot(theta,A_theta_dB_48);hold off;
plot(theta, A_theta_dB_16 - max(A_theta_dB_16));hold on;
hold on;
plot(theta, A_theta_dB_32 - max(A_theta_dB_16));
plot(theta, A_theta_dB_64 - max(A_theta_dB_16));hold off;
grid on;
xlabel('theta/radian')
ylabel('增益(dB)')
ylim([-30, 15]);
title('多种阵元均匀线阵方向图')
legend([num2str(antenna_num1),'阵元'],[num2str(antenna_num2),'阵元'],[num2str(antenna_num3),'阵元'])



