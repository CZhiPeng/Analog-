%%波束宽度和波束指向的关系图像

clc;
clear;
lamda=0.03;          %波长为0.03米
d=1/2*lamda;        %阵元间距与波长的关系
theta0=(1:0.5:80)*pi/180;   %来波方向,matlab中三角函数需要弧度
antenna_num1=16;     %阵元数
antenna_num2=32; 
antenna_num3=64;

beta_half_1=[];
beta_half_2=[];
beta_half_3=[];
beta_half_1=(1./cos(theta0))*51*(lamda/d)./antenna_num1;
beta_half_2=(1./cos(theta0))*51*(lamda/d)./antenna_num2;
beta_half_3=(1./cos(theta0))*51*(lamda/d)./antenna_num3;

plot(theta0*180/pi,beta_half_1);hold on;
plot(theta0*180/pi,beta_half_2);
plot(theta0*180/pi,beta_half_3);hold off;
xlabel('角度°')
ylabel('波束宽度（°）')
legend([num2str(antenna_num1),'阵元'],[num2str(antenna_num2),'阵元'],[num2str(antenna_num3),'阵元'])
