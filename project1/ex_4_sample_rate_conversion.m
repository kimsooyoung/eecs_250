% These examples are for sample rate conversion
% First generate a low-frequency (oversampled)
% sine wave and plot its frequency response
x=sin(2*pi*[0:1000]/20);
plot(x(1:60))
[H,w]=dft(x,2000);
figure(2)
plot(w/pi,20*log10(abs(H)))
axis([0 1 -40 60])