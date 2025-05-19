clc; clear; close all;

% Length of signal
N = 3000;

% Generate input noise signal x(n) in range [-1, 1]
x = 2 * rand(1, N) - 1;

% Define the IIR filter coefficients
b = [1, 1.5, 0.56];       % Numerator coefficients (for x terms)
a = [1, -0.7, 0.12];      % Denominator coefficients (for d terms)

% Compute the output of the unknown system d(n)
d = filter(b, a, x);

% Optional: Plot input and output signals
figure;
subplot(2,1,1);
plot(x); title('Input Signal x(n)'); xlabel('n'); ylabel('Amplitude');
subplot(2,1,2);
plot(d); title('Output Signal d(n) from Unknown System'); xlabel('n'); ylabel('Amplitude');
