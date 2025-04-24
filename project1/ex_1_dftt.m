%% generate the impulse response h[n] for a lowpass filter with cutoff freq. of 0.5*pi
wc = 0.5 * pi;
n = [-50:50];
h = sin(wc * n) ./ (pi * n);

n = [-50:50] + 0.000000001;  % to avoid division by zero at n=0
h = sin(wc * n) ./ (pi * n);
stem(n, h)

%% plot the filter frequency response, first with only rectangular window
help dtft
[H, w] = dtft(h, 500);
plot(w, 20 * log10(abs(H)))
plot(w / pi, 20 * log10(abs(H)))
grid on
hold
