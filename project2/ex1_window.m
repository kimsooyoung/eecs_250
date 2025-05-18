clc;
clear;
close all;

% Sampling frequency and normalized frequency bands
Fs = 2 * pi; % Normalized
f = linspace(0, pi, 2048);

% Desired frequency response specifications
% Passbands and stopbands
bands = [0, 0.25*pi, 0.35*pi, 0.4*pi, 0.6*pi, 0.65*pi, 0.75*pi, 0.8*pi, pi];
desired = [0, 0, 1, 1, 0, 0]; % desired gain: 0 = stopband, 1 = passband
% Define frequency and gain vectors for firpm
f_spec = [0 0.25 0.35 0.4 0.6 0.65 0.75 0.8 1];
a_spec = [0 0 1 1 0 0];

% Determine the filter length by trial and error or use Kaiser window estimate
M = 70; % Filter order (you can optimize this)
N = M + 1;

% Ideal impulse response for bandpass with multiple bands
hd = firpm(M, f_spec, a_spec);

% Apply Hamming window
w = hamming(N)';
h = hd .* w;

% Frequency response
[H, omega] = freqz(h, 1, 2048);

% Plot magnitude response in dB
figure;
plot(omega, 20*log10(abs(H) + eps), 'LineWidth', 1.5);
ylim([-60 5]);
grid on;
title('Magnitude Response of FIR Filter (Hamming Window)');
xlabel('\omega (rad/sample)');
ylabel('Magnitude (dB)');

% Highlight and zoom into transition bands
hold on;
xline(0.25*pi, '--r'); xline(0.35*pi, '--r');
xline(0.4*pi, '--g'); xline(0.6*pi, '--g');
xline(0.65*pi, '--r'); xline(0.75*pi, '--r');
xline(0.8*pi, '--k');
legend('Magnitude Response', 'Transition Bands');