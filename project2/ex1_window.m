
clc; clear; close all;

N = 54; % define the number of samples
n = [-N/2:N/2]+0.000000001; 

% -3 dB ~ 0.707 & -5dB ~ 0.562
% thus:
G_target = 0.65; %to be used to scale the other bands

G1_dB = -4; % Midpoint of -5 dB and -3 dB for Passband 1
G1 = 10^(G1_dB/20);
G2_dB = 0.5; % Midpoint of 0 dB and 1 dB for Passband 2
G2 = 10^(G2_dB/20);
G3_dB = -4; % Midpoint of -5 dB and -3 dB for Passband 3
G3 = 10^(G3_dB/20);

pass_h_1 = sin(0.35*pi*n)./(pi*n) - sin(0.25*pi*n)./(pi*n);
pass_h_2 = sin(0.6*pi*n)./(pi*n) - sin(0.4*pi*n)./(pi*n);
pass_h_3 = sin(0.75*pi*n)./(pi*n) - sin(0.65*pi*n)./(pi*n);

% ideal filter
% h = G_target*pass_h_1 + pass_h_2 + G_target*pass_h_3;
h = G1*pass_h_1 + G2*pass_h_2 + G3*pass_h_3;

% define the window
win = hamming(N+1);
hw  = h .* win';

N_fft = 500; 
[Hw, w] = dtft(hw, N_fft);

% Limit to 0 <= w <= pi
idx = w >= 0;
plot(w(idx)/pi, 20 * log10(abs(Hw(idx))), 'r');


hold on;
grid on;
title(['Filter Frequency Response (Hamming Window, N=', num2str(N)]);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');

% Define colors for clarity
specColorSb = [0.8 0 0]; % Red-ish for stopband
specColorPb13 = [0 0.6 0]; % Green-ish for passbands 1 & 3
specColorPb2 = [0 0.6 0.6]; % Cyan-ish for passband 2

% Stopband 1 (0 to 0.2*pi, <= -50dB)
line([0 0.2], [-50 -50], 'Color', specColorSb, 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 'Stopband Spec');
line([0.2 0.2], [-120 -50], 'Color', specColorSb, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical segment

% Passband 1 (0.25*pi to 0.35*pi, -5dB to -3dB)
line([0.25 0.35], [-5 -5], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 'Passband 1/3 Spec');
line([0.25 0.35], [-3 -3], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5);
line([0.25 0.25], [-5 -3], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical
line([0.35 0.35], [-5 -3], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical

% Passband 2 (0.4*pi to 0.6*pi, 0dB to 1dB)
line([0.4 0.6], [0 0], 'Color', specColorPb2, 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 'Passband 2 Spec');
line([0.4 0.6], [1 1], 'Color', specColorPb2, 'LineStyle', '--', 'LineWidth', 1.5);
line([0.4 0.4], [0 1], 'Color', specColorPb2, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical
line([0.6 0.6], [0 1], 'Color', specColorPb2, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical

% Passband 3 (0.65*pi to 0.75*pi, -5dB to -3dB)
line([0.65 0.75], [-5 -5], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5);
line([0.65 0.75], [-3 -3], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5);
line([0.65 0.65], [-5 -3], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical
line([0.75 0.75], [-5 -3], 'Color', specColorPb13, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical

% Stopband 2 (0.8*pi to pi, <= -50dB)
line([0.8 1.0], [-50 -50], 'Color', specColorSb, 'LineStyle', '--', 'LineWidth', 1.5);
line([0.8 0.8], [-120 -50], 'Color', specColorSb, 'LineStyle', '--', 'LineWidth', 1.5); % Vertical segment

ylim([-100 10]); % Adjust y-axis limits for better visualization
xlim([0 1]);
hold off;