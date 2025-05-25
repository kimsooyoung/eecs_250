clc; clear; close all;

% Parameters
N = 10;              % Length of the adaptive FIR filter
delta1 = 0.01;       % Step size for LMS
num_samples = 3000;  % Number of samples

% Generate input signal x(n): uniform random numbers in [-1,1]
x = 2*rand(1, num_samples) - 1;  % zero-mean, variance ≈ 1/3

% Define unknown system: IIR filter with given difference equation
% d(n) = 0.7*d(n-1) - 0.12*d(n-2) + x(n) + 1.5*x(n-1) + 0.56*x(n-2)
% Implement as filter with feedback (a) and feedforward (b) coefficients
a = [1 -0.7 0.12];
b = [1 1.5 0.56];
d = filter(b, a, x);  % Desired output of the unknown system

% Use LMS algorithm to estimate the system
[h_est, y] = lms(x, d, delta1, N);  % Call your lms.m function

% Compute error
e = d - y;

% Plot results
figure;
subplot(3,1,1);
plot(d, 'b');
title('Desired Signal d(n)');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,2);
plot(y, 'r');
title('LMS Filter Output y(n)');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,3);
plot(e, 'k');
title('Error Signal e(n) = d(n) - y(n)');
xlabel('n'); ylabel('Error');

% Optional: Display final estimated coefficients
disp('Estimated filter coefficients:');
disp(h_est);
