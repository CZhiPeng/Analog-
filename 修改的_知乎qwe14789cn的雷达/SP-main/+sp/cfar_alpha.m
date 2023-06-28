%--------------------------------------------------------------------------
%   [alpha] = cfar_alpha(pfa,N)
%--------------------------------------------------------------------------
%   功能：
%   根据虚警概率以及左右cfar点数N计算cfar阈值因子alpha
%   如果不清楚概念请参考matlab帮助文档 
%   Constant False Alarm Rate (CFAR) Detection
%   常用于雷达信号处理中
%--------------------------------------------------------------------------
%   输入：
%           pfa             虚警概率
%           N               计算判决点数
%   输出：
%           alpha           阈值因子
%--------------------------------------------------------------------------
function alpha = cfar_alpha(pfa,N)
disp("sum(Pn) x alpha = T")
disp("calculate alpha...")
alpha = (pfa.^(-1./N)-1);
end