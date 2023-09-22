%%这里的宽度是第一零点宽度，即FNBW
%图为FNBW与波达方向及阵元数的关系

clc;
clear;
ima=sqrt(-1);
element_num1=16;     %阵元数
element_num2=128; 
element_num3=1024;   
lamda=0.03;          %波长为0.03米
d=1/2*lamda;        %阵元间距与波长的关系
theta=0:0.5:90;

for j=1:length(theta)
    fai(j)=theta(j)*pi/180-asin(sin(theta(j)*pi/180)-lamda/(element_num1*d));
    psi(j)=theta(j)*pi/180-asin(sin(theta(j)*pi/180)-lamda/(element_num2*d));
    beta(j)=theta(j)*pi/180-asin(sin(theta(j)*pi/180)-lamda/(element_num3*d));
end
figure;
%plot(theta,fai,'r',theta,psi,'b',theta,beta,'g'),grid on
plot(theta,fai*180/pi,'r',theta,psi*180/pi,'b',theta,beta*180/pi,'g'),grid on
xlabel('theta');
%ylabel('Width in radians')
ylabel('角度（degrees）')
title('波束宽度与波达方向及阵元数的关系')
legend([num2str(element_num1),'阵元'],[num2str(element_num2),'阵元'],[num2str(element_num3),'阵元'])
