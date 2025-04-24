wc = 0.5 * pi;
n = [-50:50];
h = sin(wc * n) ./ (pi * n);

n = [-50:50] + 0.000000001;  % to avoid division by zero at n=0
h = sin(wc * n) ./ (pi * n);

%% plot the filter frequency response, first with only rectangular window
[H, w] = dtft(h, 1000);

b=firpm(40,[0 .48 .52 .78 .82 1],[1 1 0 0 1 1]);
B=dtft(b,1000);
% plot(w/pi,20*log10(abs(B)))

b=firpm(40,[0 .48 .52 .78 .82 1],[1 1 0 0 1 1],[1 10 1]);
B=dtft(b,1000);
plot(w/pi,20*log10(abs(B)))