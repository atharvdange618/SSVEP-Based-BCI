eegData = readmatrix('U0000aii.csv');

% Define your sampling rate and the number of samples in one trial.
samplingRate = 128; % Hz
numSamples = size(eegData, 1);

% Define the frequency range of interest.
freqOfInterest = [7, 12]; % Hz (Your specified frequency range)

% Calculate the FFT of the EEG data.
fftData = fft(eegData, numSamples);

% Calculate the corresponding frequency axis.
frequencies = (0:numSamples - 1) * (samplingRate / numSamples);

% Find the indices corresponding to the frequencies of interest.
freqIndices = frequencies >= freqOfInterest(1) & frequencies <= freqOfInterest(2);

% Extract the magnitude spectrum for the frequencies of interest.
magnitudeSpectra = abs(fftData(freqIndices, :));

% Calculate the corresponding frequency values for the magnitude spectrum.
frequencyValues = frequencies(freqIndices);

% Determine the three most dominant frequencies across all segments.
numDominant = 3; % Number of dominant frequencies to identify
dominantFrequencies = zeros(numDominant, size(magnitudeSpectra, 2));

for i = 1:size(magnitudeSpectra, 2)
    [~, sortedIndices] = sort(magnitudeSpectra(:, i), 'descend');
    dominantFrequencies(:, i) = frequencyValues(sortedIndices(1:numDominant));
end

% Calculate the occurrence count of each frequency
dominantFrequenciesList = dominantFrequencies(:);
uniqueFrequencies = unique(dominantFrequenciesList);
occurrenceCount = histcounts(dominantFrequenciesList, uniqueFrequencies);

% Sort frequencies by occurrence count in descending order
[sortedCount, sortedIndex] = sort(occurrenceCount, 'descend');
sortedFrequencies = uniqueFrequencies(sortedIndex);

% Select the top three most frequent frequencies
topThreeFrequencies = sortedFrequencies(1:3);

% Print the top three frequencies
fprintf('Top Three Frequencies: ');
fprintf('%.2f Hz, ', topThreeFrequencies);
fprintf('\n');
