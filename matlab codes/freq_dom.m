eegData = readmatrix('U0000aii.csv');

% Define your sampling rate and the number of samples in one trial.
samplingRate = 128; % Hz
numSamples = 7041;

% Define the frequency range of interest.
freqOfInterest = [10, 12, 7.50, 8.57]; % Hz

% Initialize arrays to store magnitude and phase features.
magnitudeFeatures = zeros(1, length(freqOfInterest));
phaseFeatures = zeros(1, length(freqOfInterest));

for i = 1:length(freqOfInterest)
    targetFrequency = freqOfInterest(i);

    % Perform FFT on the EEG data.
    fft_result = fft(eegData);

    % Compute the corresponding frequency values.
    frequency_values = (0:(length(fft_result) - 1)) * samplingRate / length(fft_result);

    % Find the index corresponding to the target frequency.
    [~, idx] = min(abs(frequency_values - targetFrequency));

    % Extract magnitude and phase features.
    magnitudeFeatures(i) = abs(fft_result(idx));
    phaseFeatures(i) = angle(fft_result(idx));
end

fprintf('Magnitude Features:\n');
for i = 1:length(magnitudeFeatures)
    fprintf('Frequency %d Hz Magnitude: %.2f\n', freqOfInterest(i), magnitudeFeatures(i));
end

fprintf('Phase Features:\n');
for i = 1:length(phaseFeatures)
    fprintf('Frequency %d Hz Phase: %.2f radians\n', freqOfInterest(i), phaseFeatures(i));
end
