eegData = readmatrix('U0000aii.csv');

% Select a specific channel (e.g., channel 1).
eegData = eegData(:, 1);

% Define your sampling rate and the number of samples in one trial.
samplingRate = 128; % Hz
numSamples = 7041;

% Define the frequency range of interest.
freqOfInterest = [10, 12, 7.50, 8.57]; % Hz

% Define STFT parameters.
windowLength = 256; % Length of the analysis window (adjust as needed).
overlap = 0.5; % Overlap between consecutive windows (adjust as needed).
nfft = 1024; % Number of FFT points (adjust as needed).

% Initialize arrays to store time-frequency features.
timeFreqFeatures = cell(length(freqOfInterest), 1);

for i = 1:length(freqOfInterest)
    targetFrequency = freqOfInterest(i);

    % Compute the STFT for the target frequency.
    [S, f, t] = spectrogram(eegData, hamming(windowLength), windowLength * overlap, nfft, samplingRate);

    % Find the index corresponding to the target frequency.
    [~, idx] = min(abs(f - targetFrequency));

    % Extract the time-frequency features.
    timeFreqFeatures{i} = abs(S(idx, :)); % Magnitude of the STFT at the target frequency.
end

disp('Time-Frequency Features:');

for i = 1:length(timeFreqFeatures)
    targetFrequency = freqOfInterest(i);
    fprintf('Frequency %d Hz:\n', targetFrequency);

    % Display the time-frequency features for the current frequency.
    disp(timeFreqFeatures{i});
    fprintf('\n'); % Add a newline for separation.
end
