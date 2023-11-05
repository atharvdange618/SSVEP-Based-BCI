% Read EEG data from the CSV file
eegData = readmatrix('U0000aii.csv');

% Define your sampling rate and the number of samples in one trial.
samplingRate = 128; % Hz
numSamples = 7041;

% Define the frequencies of interest (SSVEP frequencies)
ssvep_frequencies = [10, 8.57, 12, 7.5]; % Replace with your actual SSVEP frequencies

% Initialize variables to store spectral features
peak_powers = zeros(length(ssvep_frequencies), 1);
peak_frequencies = zeros(length(ssvep_frequencies), 1);
spectral_centroids = zeros(length(ssvep_frequencies), 1);

for i = 1:length(ssvep_frequencies)
    % Filter EEG data to retain the SSVEP frequency of interest
    eeg_filtered = bandpass(eegData, [ssvep_frequencies(i)-1, ssvep_frequencies(i)+1], samplingRate);
    
    % Perform spectral analysis using the periodogram method
    [pxx, f] = periodogram(eeg_filtered, [], [], samplingRate);
    
    % Find the index corresponding to the SSVEP frequency
    [~, index] = min(abs(f - ssvep_frequencies(i)));
    
    % Extract spectral features
    peak_powers(i) = pxx(index);
    peak_frequencies(i) = f(index);
    spectral_centroids(i) = sum(f .* pxx) / sum(pxx);
end

% Display spectral features
disp('Spectral Features (SSVEP Frequencies):');
disp('Frequency (Hz)   Peak Power   Peak Frequency (Hz)   Spectral Centroid (Hz)');
disp([ssvep_frequencies', peak_powers, peak_frequencies, spectral_centroids]);
