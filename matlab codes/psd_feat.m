eegData = readmatrix('U0000aii.csv');

% Define your sampling rate and the number of samples in one trial.
samplingRate = 128; % Hz
numSamples = 7041;

% Define the frequency range of interest.
freqOfInterest = [10, 12, 7.50, 8.57]; % Hz

% Calculate the PSD for each frequency of interest using the Welch method.
psdFeatures = zeros(1, length(freqOfInterest));

for i = 1:length(freqOfInterest)
    targetFrequency = freqOfInterest(i);
    
    % Compute the Welch PSD for the target frequency.
    [pxx, f] = pwelch(eegData, [], [], [], samplingRate);
    
    % Find the index corresponding to the target frequency.
    [~, idx] = min(abs(f - targetFrequency));
    
    % Extract the power at the target frequency.
    psdFeatures(i) = 10 * log10(pxx(idx)); % Convert power to dB.
end

% Calculate PSD features (as previously described)
fprintf('PSD Features:\n');
for i = 1:length(psdFeatures)
    fprintf('Frequency %d Hz: %.2f dB\n', freqOfInterest(i), psdFeatures(i));
end