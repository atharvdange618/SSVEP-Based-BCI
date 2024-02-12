clc;
clear;
close all;

data = table2array(readtable("12_2hz.csv"));
O1 = data(2:1280, 1);

% Plot the original time domain representation
figure;
subplot(2, 1, 1);
plot(O1);
title('O1 channel - Original Signal');
xlabel('Sample Index');
ylabel('Amplitude');

% Design a bandpass filter (example: passband between 6 Hz and 15 Hz)
lowCutoffFrequency = 6;
highCutoffFrequency = 15;
samplingFrequency = 128; % Assuming a sampling frequency of 128 Hz
nyquistFrequency = samplingFrequency / 2;
normalizedLowCutoff = lowCutoffFrequency / nyquistFrequency;
normalizedHighCutoff = highCutoffFrequency / nyquistFrequency;
filterOrder = 128; % Adjust the filter order as needed
b = fir1(filterOrder, [normalizedLowCutoff, normalizedHighCutoff], 'bandpass');
filteredO1 = filter(b, 1, O1);

% Plot the filtered time domain representation
subplot(2, 1, 2);
plot(filteredO1);
title('O1 channel - Bandpass Filtered Signal (6-15 Hz)');
xlabel('Sample Index');
ylabel('Amplitude');

% Display information about the filter
disp(['Low Cutoff Frequency: ', num2str(lowCutoffFrequency), ' Hz']);
disp(['High Cutoff Frequency: ', num2str(highCutoffFrequency), ' Hz']);
disp(['Filter Order: ', num2str(filterOrder)]);

% Compute the Fourier transform of the filtered signal
fftSize = 2^nextpow2(length(filteredO1));
fftResult = fft(filteredO1, fftSize);
frequencies = linspace(0, samplingFrequency, fftSize);

% Plot the magnitude spectrum
figure;
plot(frequencies, abs(fftResult));
title('Frequency Domain Representation - Bandpass Filtered Signal (6-15 Hz)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, samplingFrequency/2]);

% Highlight the specified frequency range
hold on;
line([lowCutoffFrequency, lowCutoffFrequency], get(gca, 'YLim'), 'Color', 'r', 'LineStyle', '--');
line([highCutoffFrequency, highCutoffFrequency], get(gca, 'YLim'), 'Color', 'r', 'LineStyle', '--');
hold off;