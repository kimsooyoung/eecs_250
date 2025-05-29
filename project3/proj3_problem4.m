clc; clear; close all;

% Parameters
N_values = [5, 10];           % FIR filter lengths
delta_values = [0.1, 0.5, 1.0];  % LMS step sizes
K_factor = 10;                % Multiplier for averaging interval
M = 3000;                     % Total number of samples

% Generate input signal x(n)
x = 2*rand(1, M) - 1;

% Define unknown system
a = [1 -0.7 0.12];
b = [1 1.5 0.56];
d = filter(b, a, x);  % Desired output

figure; % initialize plot 1
for i = 1:length(N_values)
    N = N_values(i);          % Select FIR filter length
    K = K_factor * N;         % Averaging interval

    for j = 1:length(delta_values)
        delta = delta_values(j);  % LMS step size

        % Run LMS algorithm
        [~, y] = lms(x, d, delta, N);

        % Compute error signal
        e = d - y;

        % Compute ASE over segments of size K
        num_segments = floor((M - N) / K);
        ASE = zeros(1, num_segments);
        for m = 1:num_segments
            idx_start = (m-1)*K + N + 1;
            idx_end = idx_start + K - 1;
            ASE(m) = mean(e(idx_start:idx_end).^2);
        end

        % Plot ASE for current configuration
        subplot(length(N_values), length(delta_values), (i-1)*length(delta_values)+j);
        plot(ASE, 'LineWidth', 1.5);
        xlabel('m'); ylabel('ASE(m)');
        title(sprintf('N = %d, \\Delta = %.2f', N, delta));
        grid on;
    end
end
