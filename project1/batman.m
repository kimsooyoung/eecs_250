function [gain]=batman(f)
%function [gain]=batman(f)
%
% produces the batman function
%   f - normalized frequencies between -1 and 1
%   gain - value of the function at each value of f

x=8*f(:);
Nx=length(x);
for k=1:Nx
    if x(k) < -7
        y(k)=0;
    elseif x(k) < -3
        y(k)=3*sqrt(1-(x(k)/7)^2);
    elseif x(k) < -1
        y(k)=6*sqrt(10)/7+1.5-abs(x(k))/2-6*sqrt(10)*sqrt(4-(abs(x(k))-1)^2)/14;
    elseif x(k) < -0.8
        y(k)=10*(x(k)+1)+1;
    elseif x(k) < -0.5
        y(k)=-0.8*(x(k)+0.8)/0.3+3;
    elseif x(k) < 0.5
        y(k)=2.2;
    elseif x(k) < 0.8
        y(k)=0.8*(x(k)-0.5)/0.3+2.2;
    elseif x(k) < 1
        y(k)=10*(-x(k)+1)+1;
    elseif x(k) < 3
        y(k)=6*sqrt(10)/7+1.5-abs(x(k))/2-6*sqrt(10)*sqrt(4-(abs(x(k))-1)^2)/14;
    elseif x(k) < 7
        y(k)=3*sqrt(1-(x(k)/7)^2);
    else
        y(k)=0;
    end
end
gain=y;
