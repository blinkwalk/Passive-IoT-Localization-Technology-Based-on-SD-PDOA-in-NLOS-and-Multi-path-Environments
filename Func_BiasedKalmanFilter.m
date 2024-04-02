function [X,Flag]=Func_BiasedKalmanFilter(x,X0,P0,Phi,Gamma,Q,H,R,SIGMAD,SIGMA_NLOS)
%% 用于校正NLOS误差的有偏卡尔曼滤波器

%% 本程序加入了非视距检测模块，对于NLOS使用有偏卡尔曼滤波，对于LOS使用标准卡尔曼滤波
%% 输入参数列表
%  x     输入距离观测值序列，1×N的行向量
%  X0    预测序列的初始值，1×2的列向量，包括距离和径向速度两个分量
%  P0    预测误差矩阵的初始值，2×2的矩阵
%  Phi   状态转移矩阵,2×2的矩阵
%  Gamma 噪声输入矩阵，2×1的矩阵
%  Q     输入噪声协方差矩阵，1×1的矩阵
%  H     观测矩阵，1×2的向量
%  R     观测噪声协方差矩阵，1×1的矩阵
%% 输出参数列表
%  X     预测输出值
%  Flag  NLOS标记，为1表示LOS，为0表示非视距
%%
N=length(x);
X=zeros(1,N);
X(1)=X0(1);
Flag=ones(N,1);
for i=2:N
    if i>15%因为检测区间为15个样本
        YB=x((i-15):(i));%待检测的样本
        %YB=x((i-15):(i))-X((i-15):(i));改成这个以后，无论怎么调整参数都不收敛
        YBstd=std(YB);
    else
        YBstd=0;
    end
    if YBstd>3*sqrt(SIGMAD)%如果局部样本标准差大于三倍（可改）观测误差的标准差，则判断为NLOS
        Flag(i)=0;
        %设置调整参数
        lambda=1.4;
        %由状态方程得到的预测值
        X1=Phi*X0;
        %计算上述预测的协方差矩阵
        P1=Phi*P0*(Phi')+Gamma*Q*(Gamma');
        %计算滤波增益（加权系数）
        K=P1*(H')*inv(Q*P1*(H')+lambda*R);
        %计算观察值
        Y=x(i)+lambda*R;
        %加权得到滤波输出值
        X2=X1+K*(Y-S*X1-SIGMA_NLOS);
    else
        %由状态方程得到的预测值
        X1=Phi*X0;
        %计算上述预测的协方差矩阵
        P1=Phi*P0*(Phi')+Gamma*Q*(Gamma');
        %计算滤波增益（加权系数）
%         K=P1*(H')*inv(P*P1*(H')+R);
        K=P1*(H')*inv(H*P1*(H')+R);
        %计算观察值
        Y=x(i)+R;
        %加权得到滤波输出值
        X2=X1+K*(Y-H*X1);
    end
    %记录和更新
    P2=([1,0;0,1]-K*H)*P1;
    X(i)=X2(1);
    X0=X2;
    P0=P2;
end