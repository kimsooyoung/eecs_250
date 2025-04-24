clc;
clear;

% fs = 20000;         % Sampling frequency in Hz => 20 kHz
% But, 20000/12=1666.67 is outside the range for sound function [3000, 768000]
% So I used 40000 just for sound check
fs = 40000;         
f = 1000;           % Sine wave frequency in Hz => 1000 Hz 
duration = 1;       % Duration in seconds

t = 0:1/fs:duration;            % Time vector
x = sin(2 * pi * f * t);        % Generate sine wave

size(x) % Should display [1 20001]

% Downsample kept only one of every 12 samples of the original sine wave
x_down = x(1:12:end);             % Downsampling by factor of 12
fs_down = fs / 12;                % New sampling frequency: ~1666.67 Hz
t_down = 0:1/fs_down:duration;    % Time vector for downsampled signal

% Play original signal with sound function
sound(x, fs);

% Play downsampled signal with sound function
sound(x_down, fs_down);

% Plot Original signal with downsampled signal
figure;
plot(x(1:20), 'b'); % Plot first 500 samples of original
hold on;
plot(x_down(1:20), 'r');
