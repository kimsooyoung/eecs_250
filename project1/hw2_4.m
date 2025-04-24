clc;
clear;

fs = 20000;         % Sampling frequency in Hz => 20 kHz
f = 1000;           % Sine wave frequency in Hz => 1000 Hz 
duration = 1;       % Duration in seconds

t = 0:1/fs:duration;            % Time vector
x = sin(2 * pi * f * t);        % Generate sine wave

size(x) % Should display [1 20001]

% Apply the LPF to the signal before downsampling
h = firpm(50, [0 0.2 0.3 1], [1 1 0 0]);   % Parks-McClellan low-pass filter
x_filtered = filter(h, 1, x);             % Filter the signal

% Downsample to 4 kHz like this x_down = x(1:5:end);
x_down = x_filtered(1:5:end);             % Downsample by a factor of 5
fs_down = fs / 5;                         % New sampling rate: 4 kHz

% % In case of non-filtered
% x_down = x(1:5:end);             % Downsample by a factor of 5
% fs_down = fs / 5;                         % New sampling rate: 4 kHz

% plot and display
t_down = 0:1/fs_down:duration;           % Time vector for downsampled signal

figure(1);
plot(x(101:140))
hold
plot(x_down(101:140),'r')
hold

figure(2);
[Hy,w]=dtft(x(100:end),40000);
plot(w/pi,20*log10(abs(Hy)),'r')
hold

[Ht,w]=dtft(x_down(100:end),10000);
plot(w/pi,20*log10(abs(Ht)),'g')
hold

axis([0 1 -40 60])