function [xCal] = Func_SDPDOA(x,R0,errfactor)
%Func_SDPDOA 通过SD-PDOA测距
%   x-待测距标签的水平位置
%   R0-待测距标签与天线平面的垂直位置
freq=920000000;
c=3*10^8;
%D-两天线之间的间距
D=0.1631;
R1=(R0^2+(x-D/2)^2)^(1/2);
R2=(R0^2+(x+D/2)^2)^(1/2);

phase1=mod(4*pi*freq*R1/c,2*pi)+normrnd(0,errfactor);
phase2=mod(4*pi*freq*R2/c,2*pi)+normrnd(0,errfactor);
phasedev=phase2-phase1;

 if(R2>R1&&phasedev<0) 
         phasedev=phasedev+2*pi;
 else if(R2<R1&&phasedev>0)
         phasedev=phasedev-2*pi;
      end
 end 
phaseCal = asin(c*(phasedev)/(4*pi*D*freq));
%AngleCal = phaseCal/(2*pi)*360;
%
xCal=R0*tan(phaseCal);
end

