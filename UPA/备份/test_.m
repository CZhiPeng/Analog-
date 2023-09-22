clc,clear,close all

%% 指定方向角度
theta_real = 40*pi/180;
phi_real = 25*pi/180;

antenna_num_x = [4,8,16,64];
antenna_num_y =[4,8,16,64];
%% 离散化相位
Delta = 0.05;
theta = -pi/2:Delta:pi/2;
phi = -pi/2:Delta:pi/2;

%% 初始化增益矩阵
Gain = zeros(length(theta),length(phi));
%% 天线数量
Na_vec = [4,8];
Nb_vec = [4,8];

for i = 1:2

    Na = Na_vec(i);
    Nb = Nb_vec(i);

    %% 遍历各相位，计算与之对应的波束增益
    for j = 1:length(theta)

        for k = 1:length(phi)

            V = pi*(sin(theta(j))*sin(phi(k))-sin(theta_real)*sin(phi_real))/2;
            U = pi*(sin(theta(j))*cos(phi(k))-sin(theta_real)*cos(phi_real))/2;
            Gain(j,k) = abs( sin(Nb*V) * sin(Na*U) / sin(V) / sin(U)) / (Nb*Na);
        end

    end

    %% 命令行输出增益最大的方向
    [a,b] = find(Gain==max(max(Gain)));
    disp(['增益最大的方向：',...
        'theta=',num2str(theta(a)*180/pi),'°',...
        ', phi=',num2str(phi(b)*180/pi),'°']);

    %% 绘图
    figure('position',[10+(i-1)*550 220 500 500]);
    [X,Y] = meshgrid(theta,phi);
    surf(X*180/pi,Y*180/pi,Gain');
    xlabel('\theta'); ylabel('\phi'); zlabel('Beam Gain');
    title(['Nx=',num2str(Na),', Ny=',num2str(Nb),...
        ', \phi=',num2str(phi_real*180/pi),'\circ',...
        ', \theta=',num2str(theta_real*180/pi),'\circ']);
    
end