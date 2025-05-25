function [h,y] = lms_c(x,d,delta1,N,h_init)
% LMS Algorithm with customizable initial weights
% [h,y] = lms_c(x,d,delta1,N,h_init)
%     h = estimated FIR filter
%     y = output array
%     x = input signal
%     d = desired signal
%     delta1 = step size
%     N = filter length
%     h_init = initial filter coefficients (optional)

M = length(x); 
y = zeros(1,M);

if nargin < 5
    h = zeros(1,N);  % Default: all zeros
else
    h = h_init;
end

for n = N:M
    x1 = x(n:-1:n-N+1);
    y(n) = h*x1';
    e = d(n) - y(n);
    h = h + delta1 * e * x1;
end
