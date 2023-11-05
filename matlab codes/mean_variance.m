% Load your EEG data from the CSV file
eegData = readmatrix('U0000aii.csv');

% Define your sampling rate and the number of samples in one trial.
samplingRate = 128; % Hz
numSamples = 7041;

% Define the frequency range of interest.
freqOfInterest = [10, 12, 7.50, 8.57]; % Hz

% Initialize arrays to store mean and variance values for each frequency
meanValues = zeros(1, length(freqOfInterest));
varianceValues = zeros(1, length(freqOfInterest));

% Calculate mean and variance for each frequency of interest
for i = 1:length(freqOfInterest)
    targetFrequency = freqOfInterest(i);
    
    % Extract the relevant data for the target frequency
    % You may need to adjust the indices based on your data
    startIndex = 1;
    endIndex = numSamples;  % Assuming you want to analyze the entire data
    
    % Apply bandpass filter to extract the frequency of interest
    filteredData = bandpass(eegData(startIndex:endIndex), [targetFrequency - 0.5, targetFrequency + 0.5], samplingRate);
    
    % Calculate mean and variance
    meanValues(i) = mean(filteredData);
    varianceValues(i) = var(filteredData);
end

% Display the mean and variance values in a table format
fprintf('Frequency (Hz)   Mean   Variance\n');
for i = 1:length(freqOfInterest)
    fprintf('%.2f           %.4f      %.4f\n', freqOfInterest(i), meanValues(i), varianceValues(i));
end