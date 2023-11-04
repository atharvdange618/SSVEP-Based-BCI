eegData = readmatrix('U0000aii.csv');

% Define your sampling rate.
samplingRate = 128; % Hz

% Define the frequency ranges of interest.
freqRanges = [10.00; 8.57; 7.50; 12.00]; % Hz

% Initialize arrays to store mean and variance values for each frequency range.
numFreqRanges = length(freqRanges);
meanValues = zeros(numFreqRanges, 14); % 14 represents the number of electrode locations
varianceValues = zeros(numFreqRanges, 14);

% Loop through each frequency range.
for freqIdx = 1:numFreqRanges
    targetFrequency = freqRanges(freqIdx);

    % Loop through each electrode location.
    for electrode = 1:14
        eegData = your_data(electrode, :); % Replace 'your_data' with the actual data for the electrode

        % Apply a bandpass filter to isolate the specific frequency range.
        freqRange = [targetFrequency - 0.5, targetFrequency + 0.5]; % Adjust the bandwidth as needed
        bpFilt = designfilt('bandpassiir', 'FilterOrder', 10, 'HalfPowerFrequency1', freqRange(1), 'HalfPowerFrequency2', freqRange(2), 'SampleRate', samplingRate);
        filteredData = filtfilt(bpFilt, eegData);

        % Calculate the mean and variance for the filtered data.
        meanValue = mean(filteredData);
        varianceValue = var(filteredData);

        % Store the results in the arrays.
        meanValues(freqIdx, electrode) = meanValue;
        varianceValues(freqIdx, electrode) = varianceValue;
    end
end

% Display the results in a tabular format.
fprintf('Frequency (Hz)\tElectrode\tMean\tVariance\n');
for freqIdx = 1:numFreqRanges
    targetFrequency = freqRanges(freqIdx);
    for electrode = 1:14
        fprintf('%.2f\tElectrode %d\t%.2f\t%.2f\n', targetFrequency, electrode, meanValues(freqIdx, electrode), varianceValues(freqIdx, electrode));
    end
end
