clc;
clear;
close all;

data = table2array(readtable("10hz.csv"));
O1 = data(2:1280,1);
% plot(O1);
% title('O1 channel');

from = 2;
to = 128;

for i = 1:10
    if to < length(O1)
        O1_section = O1(from:to);

        feature(i,1) = mean(O1_section);
        feature(i,2) = std(O1_section);
        feature(i,3) = var(O1_section);
        feature(i,4) = skewness(O1_section);
        feature(i,5) = kurtosis(O1_section);

        from = from + 128;
        to = to + 128;
    end
end