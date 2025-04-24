clc;
clear;

fs = 20000;         % Sampling frequency in Hz => 20 kHz
f = 1000;           % Sine wave frequency in Hz => 1000 Hz 
duration = 1;       % Duration in seconds

t = 0:1/fs:duration;            % Time vector
x = sin(2 * pi * f * t);        % Generate sine wave

size(x) % Should display [1 20001]

% Upsample to 100 kHz
% Upsampling factor L = 100 kHz / 20 kHz = 5
L = 5;
% Create upsampled signal by inserting L-1 zeros between each sample
x_up = zeros(1, length(x) * L);

x_up(1:L:end) = x; % Place original samples at every Lth position
fs_up = fs * L; % New sampling frequency = 100 kHz

% Check the sound
sound(x_up, fs_up);

t_up = 0:1/fs_up:duration; % New time vector

h = firpm(100, [0 0.2 0.3 1], [5 5 0 0]);
x_upsampled = conv(x_up, h);

% Check the sound
sound(x_upsampled, fs_up);

figure(1);
plot(x(101:200))
hold
plot(x_upsampled (101:200),'r')
hold

figure(2);
[Hy,w]=dtft(x(100:end),100000);
plot(w/pi,20*log10(abs(Hy)),'r')
hold
[Ht,w]=dtft(x_up(100:end),500000);
plot(w/pi,20*log10(abs(Ht)),'g')

axis([0 1 -40 100])