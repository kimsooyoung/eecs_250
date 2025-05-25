clc; clear; close all;

% Parameters
N_list = [5, 10];           % FIR filter lengths to try
delta_list = [0.01, 0.05, 0.1, 0.2, 0.5, 0.7, 1.0, 2.0, 4.0];  % Step sizes
num_samples = 3000;         % Total number of samples

% Generate input signal x(n)
x = 2*rand(1, num_samples) - 1;

% Define unknown system
a = [1 -0.7 0.12];
b = [1 1.5 0.56];
d = filter(b, a, x);  % Output of unknown system

% Loop over FIR lengths
for N_idx = 1:length(N_list)
    N = N_list(N_idx);
    K = 10 * N;  % Averaging interval

    figure;
    hold on;
    legend_entries = {};
    
    % Loop over step sizes
    for delta_idx = 1:length(delta_list)
        delta1 = delta_list(delta_idx);
        
        % Apply LMS
        [~, y] = lms(x, d, delta1, N);
        e = d - y;
        
        % Compute ASE(m)
        m_values = 0:K:(num_samples - K);
        ASE = zeros(1, length(m_values));
        for m_idx = 1:length(m_values)
            n = m_values(m_idx);
            ASE(m_idx) = mean(e(n+1:n+K).^2);
        end

        % Plot ASE(m)
        plot(m_values, ASE, 'DisplayName', ['\Delta = ', num2str(delta1)]);
        legend_entries{end+1} = ['\Delta = ', num2str(delta1)];
    end

    hold off;
    xlabel('Sample index n');
    ylabel('ASE(m)');
    title(['ASE vs n for FIR filter length N = ', num2str(N)]);
    legend('show');
    grid on;
end
