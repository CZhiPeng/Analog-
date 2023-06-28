N = 16;                             
theta1 = (1 : 1 : 360) / 180 * pi;
x=0;

for theta_k = (0:2:90)/ 180 * pi    %注：入射角是[0,90]
    for i = 0 : N-1
      x = x + exp(-1j *i*pi * (sin(theta1)-sin(theta_k)));
    end
    x=x/N;

    subplot(121)
    polarplot(theta1, abs(x));
    title('极坐标天线增益')
    subplot(122)
    plot(theta1, db(x));  
    title('天线增益');xlabel('角度 ');ylabel('增益 db');grid on
    pause(0.2)
    drawnow()
end
