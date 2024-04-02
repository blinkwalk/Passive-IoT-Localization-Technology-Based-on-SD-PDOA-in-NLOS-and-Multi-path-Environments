function [a,b]=Func_LOCATION_CAL(c1,c2,c3,c4,dif1,dif2)
%c1,c2,曲线一焦点的横坐标，c3,c4，曲线二的横坐标，默认纵坐标都为0
%dif1,dif2 到两个焦点的距离差
%构建方程组
syms x y;
center1 = (c1+c2) /2;
center2 = (c3+c4) /2;
c1_2 = abs(center1-c1).^2;
c2_2 = abs(center2-c3).^2;
 a1_2 = dif1^2/4;
 a2_2 = dif2^2/4;
 b1_2 = c1_2 - a1_2;
 b2_2 = c2_2 - a2_2;
 
[a_,b_] = solve((x-center1)^2/a1_2-y^2/b1_2==1,(x-center2)^2/a2_2-y^2/b2_2==1);
a = real(a_);
b = real(b_);
plot(a,b,'r*');
xlim([60 150]);
ylim([-100 100]);
hold on;
end


