% Load your EEG data
eeg_data = readmatrix("U0000aii.csv");

% Define the sampling rate (adjust as needed)
sampling_rate = 128;  % Replace with your actual sampling rate (in Hz)

% Define the duration of the signal (in seconds)
signal_duration = size(eeg_data, 1) / sampling_rate;

% Create a time vector
time_vector = (0:(size(eeg_data, 1) - 1)) / sampling_rate;

% Plot EEG data in time domain for all channels on a single graph
figure;
hold on;  % Enable holding for multiple channel plots
for i = 1:size(eeg_data, 2)
    plot(time_vector, eeg_data(:, i));
end
xlabel('Time (s)');
ylabel('Amplitude');
title('EEG Data in Time Domain - All Channels');
hold off;  % Release hold

% Print Time Domain Analysis Results
disp('Time Domain Analysis Results:');
disp(['Signal Duration: ' num2str(signal_duration) ' seconds']);
