% Make sure you have the batman.m function defined or on your path

figure;
samples_to_test = [8, 12, 16, 20, 24];  % Try various sample counts
f = linspace(-1, 1, 500);
bat = batman(f);  % Reference batman shape

% Plot batman function for reference
subplot(length(samples_to_test)+1, 1, 1);
plot(f, 20*log10(abs(bat)), 'k', 'LineWidth', 1.5);
title('Target Batman Frequency Response');
ylabel('Gain (dB)');
grid on;
axis([-1 1 -40 5]);

mallest number of samples

for i = 1:length(samples_to_test)
    N = samples_to_test(i);
    
    % Construct X with N nonzero values centered in a larger vector
    X = zeros(1, 40);
    start_idx = floor((length(X) - N) / 2) + 1;
    X(start_idx:start_idx + N - 1) = 1;

    x = ifft(X);
    h = fftshift(x);
    
    [H, w] = dtft(h, 500);
    
    subplot(length(samples_to_test)+1, 1, i+1);
    plot(w/pi, 20*log10(abs(H)), 'b');
    title(['Spectrum with ', num2str(N), ' samples']);
    ylabel('Gain (dB)');
    grid on;
end

xlabel('Normalized Frequency (\omega/\pi)');