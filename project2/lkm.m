
N = 100; % define the number of samples
n = -N/2:N/2; % get range from N
n = n + 1e-9; % adjust slightly to avoid Zero division bs


% -3 dB ~ 0.707 & -5dB ~ 0.562
% thus:
G_target = 0.65; %to be used to scale the other bands

% define the ideal band pass filters
h1 = (sin(0.35*pi*n)./(pi*n)) - sin(0.25*pi*n)./(pi*n); % band [0.25, 0.35]
h2 = (sin(0.6*pi*n)./(pi*n)) - sin(0.4*pi*n)./(pi*n); % band [0.4, 0.6]
h3 = (sin(0.75*pi*n)./(pi*n)) - sin(0.65*pi*n)./(pi*n); % band [0.65, 0.75]
% h = G_target*h1 + h2 + G_target*h3;
h = h1 + h2 + h3;

%figure();
%stem(n, h)
% define the window
win = hamming(N+1);
hw  = h.*win';
[Hw, w] = dtft(hw, 500);


figure();
plot(w/pi, 20 * log10(abs(Hw)), 'b');
% fvtool(hw, 1);

