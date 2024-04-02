function [RMSE] = Func_RMSE_Cal(realPosX,realPosY,estPosX,estPosY)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
RmseSum=0;
    for i =1:length(estPosX)
        RmseSum = RmseSum+(((estPosX(i)-realPosX)^2+(abs(estPosY(i))-abs(realPosY))^2)^(1/2));
    end
    RMSE=RmseSum/length(estPosX);
end