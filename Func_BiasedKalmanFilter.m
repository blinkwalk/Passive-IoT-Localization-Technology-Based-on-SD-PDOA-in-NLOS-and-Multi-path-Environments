function [X,Flag]=Func_BiasedKalmanFilter(x,X0,P0,Phi,Gamma,Q,H,R,SIGMAD,SIGMA_NLOS)
%% ����У��NLOS������ƫ�������˲���

%% ����������˷��Ӿ���ģ�飬����NLOSʹ����ƫ�������˲�������LOSʹ�ñ�׼�������˲�
%% ��������б�
%  x     �������۲�ֵ���У�1��N��������
%  X0    Ԥ�����еĳ�ʼֵ��1��2������������������;����ٶ���������
%  P0    Ԥ��������ĳ�ʼֵ��2��2�ľ���
%  Phi   ״̬ת�ƾ���,2��2�ľ���
%  Gamma �����������2��1�ľ���
%  Q     ��������Э�������1��1�ľ���
%  H     �۲����1��2������
%  R     �۲�����Э�������1��1�ľ���
%% ��������б�
%  X     Ԥ�����ֵ
%  Flag  NLOS��ǣ�Ϊ1��ʾLOS��Ϊ0��ʾ���Ӿ�
%%
N=length(x);
X=zeros(1,N);
X(1)=X0(1);
Flag=ones(N,1);
for i=2:N
    if i>15%��Ϊ�������Ϊ15������
        YB=x((i-15):(i));%����������
        %YB=x((i-15):(i))-X((i-15):(i));�ĳ�����Ժ�������ô����������������
        YBstd=std(YB);
    else
        YBstd=0;
    end
    if YBstd>3*sqrt(SIGMAD)%����ֲ�������׼������������ɸģ��۲����ı�׼����ж�ΪNLOS
        Flag(i)=0;
        %���õ�������
        lambda=1.4;
        %��״̬���̵õ���Ԥ��ֵ
        X1=Phi*X0;
        %��������Ԥ���Э�������
        P1=Phi*P0*(Phi')+Gamma*Q*(Gamma');
        %�����˲����棨��Ȩϵ����
        K=P1*(H')*inv(Q*P1*(H')+lambda*R);
        %����۲�ֵ
        Y=x(i)+lambda*R;
        %��Ȩ�õ��˲����ֵ
        X2=X1+K*(Y-S*X1-SIGMA_NLOS);
    else
        %��״̬���̵õ���Ԥ��ֵ
        X1=Phi*X0;
        %��������Ԥ���Э�������
        P1=Phi*P0*(Phi')+Gamma*Q*(Gamma');
        %�����˲����棨��Ȩϵ����
%         K=P1*(H')*inv(P*P1*(H')+R);
        K=P1*(H')*inv(H*P1*(H')+R);
        %����۲�ֵ
        Y=x(i)+R;
        %��Ȩ�õ��˲����ֵ
        X2=X1+K*(Y-H*X1);
    end
    %��¼�͸���
    P2=([1,0;0,1]-K*H)*P1;
    X(i)=X2(1);
    X0=X2;
    P0=P2;
end