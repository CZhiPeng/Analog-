%% 波束宽度和天线数量的关系：波束分辨率越高，波束宽度越小；

%天线阵列所达到的空间分辨率可以通过array factor (AF) 的半功率波束宽度来定量描述。[1]
%[1]J. Wu, C. Zhang, H. Liu and J. Yan, "Performance Analysis of Circular Antenna Array for Microwave Interferometric Radiometers," 
% in IEEE Transactions on Geoscience and Remote Sensing, vol. 55, no. 6, pp. 3261-3271, June 2017, doi: 10.1109/TGRS.2017.2667042.


clc;
clear;
lamda=0.03;          %波长为0.03米
d=1/2*lamda;        %阵元间距与波长的关系
theta0=3*pi/180;   %来波方向,matlab中三角函数需要弧度
antenna_num = 1 : 1 : 100;
beta_half=(1/cos(theta0))*51*(lamda/d)./antenna_num;
plot(antenna_num,beta_half,'r')
xlabel('天线数量')
ylabel('波束宽度（°）')
text(16, (1/cos(theta0))*51*(lamda/d)./16,'*','color','r')
text(16, (1/cos(theta0))*51*(lamda/d)./16, ['(',num2str(16),',',num2str((1/cos(theta0))*51*(lamda/d)./16),')'],'color','r');
text(32, (1/cos(theta0))*51*(lamda/d)./32,'*','color','k')
text(32, (1/cos(theta0))*51*(lamda/d)./32, ['(',num2str(32),',',num2str((1/cos(theta0))*51*(lamda/d)./32),')'],'color','k');
text(64, (1/cos(theta0))*51*(lamda/d)./64,'*','color','g')
text(64, (1/cos(theta0))*51*(lamda/d)./64, ['(',num2str(64),',',num2str((1/cos(theta0))*51*(lamda/d)./64),')'],'color','g')
% hold on;
% beta_half_1=2*abs(theta0-asin(0.88./antenna_num+sin(theta0)))*180/pi;
% plot(antenna_num,beta_half_1,'g')