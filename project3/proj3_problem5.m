% Impulse Response Comparison after LMS Convergence
clc; clear; close all;

% Unknown system: same as previous
b = [1 1.5 0.56];
a = [1 -0.7 0.12];

% FIR lengths to test
Ns = [5, 10];
delta1 = 0.01;
M = 3000;  % length of training signal

for i = 1:length(Ns)
    N = Ns(i);
    x = 2*rand(1, M) - 1;             % Noise input
    d = filter(b, a, x);             % Desired output
    [h_est, y] = lms(x, d, delta1, N); % Adaptive filter

    % Impulse responses
    imp = [1 zeros(1, 49)];                  % Unit impulse δ(n)
    h_true = filter(b, a, imp);             % Unknown system's impulse
    h_fir = filter(h_est, 1, imp);          % LMS-estimated FIR impulse
    
    % Plotting
    figure;
    stem(h_fir(1:20), 'r', 'filled', 'LineWidth', 2.5, 'MarkerSize', 6); hold on;
    stem(h_true(1:20), 'b', 'filled', 'LineWidth', 1.2); hold on;
    title(['Impulse Response Comparison (N = ', num2str(N), ')']);
    legend('Unknown System', 'Estimated FIR');
    xlabel('n'); ylabel('Amplitude');
end