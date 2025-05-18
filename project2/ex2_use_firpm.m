clc; clear; close all;

N = 60; % define the number of samples
n = [-N/2:N/2]+0.000000001; 

% Normalized frequency vector (normalized by pi, so 1.0 corresponds to pi)
f_edges = [0, 0.2, 0.25, 0.35, 0.4, 0.6, 0.65, 0.75, 0.8, 1.0];

amp_sb = 0;

% Passband 1 & 3: [-5 dB, -3 dB]
lin_min_pb1 = 10^(-5/20); % 0.5623
lin_max_pb1 = 10^(-3/20); % 0.7079
amp_pb1 = (lin_min_pb1 + lin_max_pb1) / 2; % 0.6351

% Passband 2: [0 dB, 1 dB]
lin_min_pb2 = 10^(0/20);  % 1.0
lin_max_pb2 = 10^(1/20);  % 1.1220
amp_pb2 = (lin_min_pb2 + lin_max_pb2) / 2; % 1.0610

% Amplitude vector for firpm
a_desired = [amp_sb, amp_sb, amp_pb1, amp_pb1, amp_pb2, amp_pb2, amp_pb1, amp_pb1, amp_sb, amp_sb];

% Deviations for weights
dev_sb = 10^(-50/20);         % 0.00316 (max allowed ripple in stopband around 0)
dev_pb1 = (lin_max_pb1 - lin_min_pb1) / 2; % 0.0728 (allowed ripple around amp_pb1)
dev_pb2 = (lin_max_pb2 - lin_min_pb2) / 2; % 0.0610 (allowed ripple around amp_pb2)

weights = [1/dev_sb, 1/dev_pb1, 1/dev_pb2, 1/dev_pb1, 1/dev_sb];

% Design the filter using firpm
b = firpm(N, f_edges, a_desired, weights);

% Verification (Optional but recommended)
N_fft = 500; 
[Hw, w] = dtft(b, N_fft);

% Limit to 0 <= w <= pi
idx = w >= 0;
plot(w(idx)/pi, 20 * log10(abs(Hw(idx))));

grid on;
hold on;
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title(['FIR Filter Magnitude Response (N = ', num2str(N), ')']);

% Plot specification boundaries
% Stopband 1
line([0 0.2], [-50 -50], 'Color', 'r', 'LineStyle', '--', 'DisplayName', 'Spec SB1');
line([0.2 0.2], [-100 -50], 'Color', 'r', 'LineStyle', '--'); % Vertical line for clarity

% Passband 1
line([0.25 0.35], [-5 -5], 'Color', 'g', 'LineStyle', '--', 'DisplayName', 'Spec PB1 Lower');
line([0.25 0.35], [-3 -3], 'Color', 'g', 'LineStyle', '--', 'DisplayName', 'Spec PB1 Upper');
line([0.25 0.25], [-10 -2], 'Color', 'g', 'LineStyle', '--');
line([0.35 0.35], [-10 -2], 'Color', 'g', 'LineStyle', '--');

% Passband 2
line([0.4 0.6], [0 0], 'Color', 'b', 'LineStyle', '--', 'DisplayName', 'Spec PB2 Lower');
line([0.4 0.6], [1 1], 'Color', 'b', 'LineStyle', '--', 'DisplayName', 'Spec PB2 Upper');
line([0.4 0.4], [-2 2], 'Color', 'b', 'LineStyle', '--');
line([0.6 0.6], [-2 2], 'Color', 'b', 'LineStyle', '--');

% Passband 3
line([0.65 0.75], [-5 -5], 'Color', 'm', 'LineStyle', '--', 'DisplayName', 'Spec PB3 Lower');
line([0.65 0.75], [-3 -3], 'Color', 'm', 'LineStyle', '--', 'DisplayName', 'Spec PB3 Upper');
line([0.65 0.65], [-10 -2], 'Color', 'm', 'LineStyle', '--');
line([0.75 0.75], [-10 -2], 'Color', 'm', 'LineStyle', '--');

% Stopband 2
line([0.8 1.0], [-50 -50], 'Color', 'r', 'LineStyle', '--', 'DisplayName', 'Spec SB2');
line([0.8 0.8], [-100 -50], 'Color', 'r', 'LineStyle', '--');

ylim([-100 5]); % Adjust ylim for better visualization
hold off;

% Display filter coefficients
disp('Filter coefficients b:');
disp(b);