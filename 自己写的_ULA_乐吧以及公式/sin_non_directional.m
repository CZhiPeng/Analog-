%%theta_k的定向，阵列导向矢量是正常的sin函数
N = 16;
x=0;
theta1 = (1 : 1 : 360) / 180 * pi;
for i = 0 : N-1
   x = x + exp(-1j *i*pi * (sin(theta1)));
end
%阵列导向矢量中元素的累加，也便是乐吧中的(sin(N * (deltaphi-deltaphi0)/2) ./ sin((deltaphi-deltaphi0)/2)) / N
x=x/N;%归一化
polarplot(theta1, abs(x))


