close all;
clc;
clear;

% This file contains portion of Tchaikovsky’s famous 
% “Dance of the Sugar Plum Fairy” sampled at 44.1 kHz. 
load tchaikovsky.mat
originalFs = 44100;

% Downsample the file so the new sampling rates are 
% 5/6 , 2/3 , 1/2 , 1/3 , 1/6 of the original rate respectively.
% For the cases of 1/2 , 1/3 and 1/6, 
% downsample without using the low-pass filter. 

ratios = [5/6, 2/3, 1/2, 1/3, 1/6];
labels = ["5/6", "2/3", "1/2", "1/3", "1/6"];
sampled_music = cell(1, length(ratios));  % Use cell array to store different-length signals

for i = 1:length(ratios)
    ratio = ratios(i);
    newFs = originalFs * ratio;

    fprintf('\n--- Playing %s of original (%.0f Hz) ---\n', labels(i), newFs);
    
    % If ratio > 1/2, apply anti-aliasing filter
    if ratio > 1/2
        sampled_music{i} = resample(sugar_plum, round(ratio*1000), 1000);  % Uses anti-aliasing
    else
        step = round(1/ratio);
        sampled_music{i} = sugar_plum(1:step:end);  % No filtering
    end

    % Plot a short segment of each version
    figure(i);
    % plot(sampled_music{i}(60000*ratios(i):120000*ratios(i)));
    % title(['Downsampled at ', labels(i), ' of Original Rate']);
    [Ht,w] = dtft(sampled_music{i}(2766448:end),2000000);
    plot(w/pi,20*log10(abs(Ht)),'g')

    % sound(sampled_music{i}, round(newFs));
    % pause(length(sampled_music{i})/newFs + 1); % Wait for playback to finish
end