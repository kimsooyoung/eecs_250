pause on;

x=sin(2*pi*[0:1000]/20);
plot(x(1:60))
[H,w]=dtft(x,2000);
plot(w/pi,20*log10(abs(H)))
hold
pause(0.1);

% upsample by a factor of 3, which
% means we insert two zeros in between each
% sample of our sinewave
size(x)
Z=[x;zeros(2,1001)];
z=Z(:);
% stem(z(1:50))

h=firpm(50,[0 0.2 0.3 1],[3 3 0 0]);
y=conv(z,h);
% plot(x(101:200))
% hold
% plot(y(101:200),'r')
% hold

% Plot the frequency response of the upsampled and
% interpolated signal together with the frequency response of the
% original signal
[Hy,w]=dtft(y(50:end),4000);
plot(w/pi,20*log10(abs(Hy)),'r')
hold
% axis([0 1 -40 60])
pause(0.1);

% Now we go back to the time-domain and down-sample by a factor
% of 5, and plot the resulting signal in the time and frequency
% domains
t=y(1:5:end);
% plot(t(101:200),'g')
[Ht,w]=dtft(t(10:end),2000);
plot(w/pi,20*log10(abs(Ht)),'g')
hold
axis([0 1 -40 60])