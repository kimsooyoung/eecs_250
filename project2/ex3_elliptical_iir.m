
clc; clear; close all;

attenuation = 55;

% --- Filter 1: Passband [0.25*pi, 0.35*pi] ---
Wp1 = [0.25, 0.35];         % Passband edge frequencies (normalized)
Ws1 = [0.2, 0.4];           % Stopband edge frequencies (normalized)
Rp1 = 0.65;                 % Passband ripple in dB (-3dB - (-5dB))
target_gain1_dB = -4;       % Target mean gain in dB for passband 1
scale1 = 10^(target_gain1_dB/20);
[N, ~]      = ellipord(Wp1, Ws1, Rp1, attenuation);
[b1, a1]    = ellip(N, Rp1, attenuation, Wp1);

%bandpass [0.4, 0.6]
% --- Filter 2: Passband [0.4*pi, 0.6*pi] ---
Wp2 = [0.4, 0.6];           % Passband edge frequencies (normalized)
Ws2 = [0.35, 0.65];         % Stopband edge frequencies (normalized)
Rp2 = 0.65;                 % Passband ripple in dB (1dB - 0dB)
target_gain2_dB = 0.5;      % Target mean gain in dB for passband 2
scale2 = 10^(target_gain2_dB/20);
[N, ~]      = ellipord(Wp2, Ws2, Rp2, attenuation);
[b2, a2]    = ellip(N, Rp2, attenuation, Wp2);

% --- Filter 3: Passband [0.65*pi, 0.75*pi] ---
Wp3 = [0.65, 0.75];         % Passband edge frequencies (normalized)
Ws3 = [0.6, 0.8];           % Stopband edge frequencies (normalized)
Rp3 = 0.65;                 % Passband ripple in dB (-3dB - (-5dB))
target_gain3_dB = -4;       % Target mean gain in dB for passband 3
scale3 = 10^(target_gain3_dB/20);
[N, ~]      = ellipord(Wp3, Ws3, Rp3, attenuation);
[b3, a3]    = ellip(N, Rp3, attenuation, Wp3);

% parallel conv
a = conv(conv(a1, a2), a3);  % Overall denominator
% b12 in the template likely means the effective numerator for the first branch
b12 = scale1 * conv(b1, conv(a2, a3));
% b21 in the template likely means the effective numerator for the second branch
b21 = scale2 * conv(b2, conv(a1, a3));
% b31 in the template likely means the effective numerator for the third branch
b31 = scale3 * conv(b3, conv(a1, a2));
b = b12 + b21 + b31;

% fvtool(b,a);

N_fft = 4096; % Number of points for FFT
[H, W_rad_per_sample] = freqz(b, a, N_fft);
W_hz_norm = W_rad_per_sample / pi; % Normalized frequency (0 to 1, where 1 is Nyquist)

% Phase Response
plot(W_hz_norm, angle(H)); % Phase in radians
title('Phase Response');
xlabel('Normalized Frequency (w/pi)');
ylabel('Phase (radians)');
grid on;

% Group Delay
[gd, W_gd] = grpdelay(b, a, N_fft);
plot(W_gd/pi, gd);
title('Group Delay');
xlabel('Normalized Frequency (w/pi)');
ylabel('Group Delay (samples)');
grid on;
