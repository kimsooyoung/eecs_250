clc; clear; close all;

% Parameters
N = 3000;  % Length of the signal

% Generate uniformly distributed random numbers in the interval [-1, 1]
x = 2 * rand(1, N) - 1;

% Calculate mean and variance for verification
mean_x = mean(x);
var_x = var(x);

% Display results
fprintf('Mean of x: %.4f\n', mean_x);
fprintf('Variance of x: %.4f\n', var_x);