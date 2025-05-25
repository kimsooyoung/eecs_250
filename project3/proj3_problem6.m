clc; clear; close all;

% Parameters
N = 5;
delta1 = 0.01;
M = 1000;
K = 10 * N;

% Input signal
x = 2*rand(1,M) - 1;

% Unknown IIR system
b = [1 1.5 0.56];
a = [1 -0.7 0.12];
d = filter(b, a, x);

% LMS with custom initializations
h_init1 = zeros(1,N);         % Default zero
h_init2 = ones(1,N) * 0.5;    % All 0.5
h_init3 = rand(1,N) * 0.1;    % Small random init

% Run LMS for different inits
[h1,y1] = lms_c(x,d,delta1,N,h_init1);
[h2,y2] = lms_c(x,d,delta1,N,h_init2);
[h3,y3] = lms_c(x,d,delta1,N,h_init3);

% Compute ASE
n_vals = 0:K:M-K-1;
ASE1 = zeros(size(n_vals));
ASE2 = zeros(size(n_vals));
ASE3 = zeros(size(n_vals));

for i = 1:length(n_vals)
    n = n_vals(i);
    ASE1(i) = mean((d(n+1:n+K) - y1(n+1:n+K)).^2);
    ASE2(i) = mean((d(n+1:n+K) - y2(n+1:n+K)).^2);
    ASE3(i) = mean((d(n+1:n+K) - y3(n+1:n+K)).^2);
end

% Plot ASE for different inits
figure;
plot(n_vals, ASE1, 'b', n_vals, ASE2, 'r--', n_vals, ASE3, 'g-.');
legend('Zero init','0.5 init','Random small init');
xlabel('n'); ylabel('ASE');
title('Average Squared Error for Different Initializations');

% Plot impulse response comparison (Part b)
impulse = [1 zeros(1,49)];
resp_iir = filter(b, a, impulse);

figure;
subplot(4,1,1);
stem(resp_iir(1:N)); 
title('Unknown IIR Impulse Response'); 
ylabel('Amplitude');

subplot(4,1,2);
stem(h1); 
title('Estimated FIR h (zero init)'); 
ylabel('Amplitude');

subplot(4,1,3);
stem(h2); 
title('Estimated FIR h (0.5 init)'); 
ylabel('Amplitude');

subplot(4,1,4);
stem(h3); 
title('Estimated FIR h (random small init)'); 
xlabel('Tap Index');
ylabel('Amplitude');