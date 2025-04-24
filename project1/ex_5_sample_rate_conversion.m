x=sin(2*pi*[0:1000]/20);
plot(x(1:60))
[H,w]=dtft(x,2000);
figure(2)
plot(w/pi,20*log10(abs(H)))
