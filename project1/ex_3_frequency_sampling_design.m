X=[1 1 1 zeros(1,15) 1 1];
x=ifft(X);
h=fftshift(x);
[H,w]=dtft(h,500);
plot(w/pi,20*log10(abs(H)))
axis([-1 1 -40 5])

%% Normalized Frequency
X=[1 1 0.8 0.3 zeros(1,13) 0.3 0.8 1];
x=ifft(X);
h=fftshift(x);
[H,w]=dtft(h,500);
plot(w/pi,20*log10(abs(H)))
axis([-1 1 -40 5])