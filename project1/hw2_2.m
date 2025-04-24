fs = 20000;         % Sampling frequency in Hz
f = 1000;           % Sine wave frequency in Hz
duration = 1;       % Duration in seconds

t = 0:1/fs:duration;            % Time vector
y = sin(2 * pi * f * t);        % Generate sine wave

% Plot the waveform (first few milliseconds for clarity)
figure;
plot(t(1:200), y(1:200));       % Plot the first 200 samples (10 ms)
axis([-0.002 0.012 -2 2])
xlabel('Time (seconds)');
ylabel('Amplitude');
title('1000 Hz Sine Wave Sampled at 20 kHz');

% Play the sound
sound(y, fs);