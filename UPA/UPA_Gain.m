function [Gain] = UPA_Gain(antenna_num_x,antenna_num_y,theta0,phi0,Delta)
%输出波束增益
%   antenna_num_x为x轴的天线个数，antenna_num_y为y轴的天线个数，theta0和phi0是要指向的俯仰角和方位角
d_lamda=1/2; 
%% 离散化相位
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;
%% 初始化增益矩阵
Gain = zeros(length(theta),length(phi));

%% 波束赋形向量,用于相位补偿
w1=exp(-1*1i*2*pi*d_lamda*sin(theta0)*cos(phi0).*(0:antenna_num_x-1)');
w2=exp(-1*1i*2*pi*d_lamda*(sin(theta0)*sin(phi0)).*(0:antenna_num_y-1)');
w=kron(w1,w2);

%% 导向矢量,发射波束增益，阵列在XOY平面
    for j = 1:length(theta)
        for k = 1:length(phi)
            a1=exp(-1*1i*2*pi*d_lamda*sin(theta(j))*cos(phi(k)).*(0:antenna_num_x-1)');%x轴导向矢量
            a2=exp(-1*1i*2*pi*d_lamda*(sin(theta(j))*sin(phi(k))).*(0:antenna_num_y-1)');%y轴导向矢量
            a=kron(a1,a2); %整体导向矢量,b:(antenna_num_x(i)*antenna_num_y(i))*1
            Gain(j, k) = w' * a./(antenna_num_y*antenna_num_x); %发射波束增益=w'*a,并且归一化
            Gain(j, k) = abs(Gain(j, k));
        end
    end

end

