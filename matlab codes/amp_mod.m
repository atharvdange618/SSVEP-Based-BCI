eegData = readmatrix('U0000aii.csv');

% Define your sampling rate and the number of samples in one trial.
samplingRate = 128; % Hz
numSamples = 7041;

% Define the frequency range of interest.
freqOfInterest = [10, 12, 7.50, 8.57]; % Hz

% Define the bandwidth for the bandpass filter (adjust as needed).
bandwidth = 9.0; % Hz

% Initialize arrays to store modulation depths.
modulationDepths = zeros(length(freqOfInterest), 1);

% Loop through each frequency of interest.
for i = 1:length(freqOfInterest)
    targetFrequency = freqOfInterest(i);

    % Apply a bandpass filter to isolate the frequency of interest.
    nyquist = samplingRate / 2;
    lowFreq = targetFrequency - bandwidth / 2;
    highFreq = targetFrequency + bandwidth / 2;
    lowCut = lowFreq / nyquist;
    highCut = highFreq / nyquist;
    order = 4; % Filter order (adjust as needed).
    [b, a] = butter(order, [lowCut, highCut]);

    filteredData = filtfilt(b, a, eegData);

    % Calculate the Hilbert transform to obtain the analytic signal.
    analyticSignal = hilbert(filteredData);

    % Calculate the envelope (amplitude) of the analytic signal.
    envelope = abs(analyticSignal);

    % Calculate the modulation depth.
    modulationDepth = std(envelope) / mean(envelope);

    % Store the modulation depth for this frequency.
    modulationDepths(i) = modulationDepth;
end

% Display the modulation depths for each frequency.
disp('Modulation Depths:');
for i = 1:length(freqOfInterest)
    fprintf('Frequency %f Hz: %.4f\n', freqOfInterest(i), modulationDepths(i));
end
