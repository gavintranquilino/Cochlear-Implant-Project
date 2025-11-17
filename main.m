clear; clc; close all;

% inputFile = "Audio Track 4.mp3";
inputFile = "track2.mp3";
outputFile = "track2-mono.mp3";

signal = phase1(inputFile, outputFile, 16000);

% Uncomment to produce lowest and highest frequency bands for each section
buttterworth_bands = phase2(signal, @phase2Filters.butterworth, "Butterworth", 100, 7999, 8, 16000);
chebyone_bands = phase2(signal, @phase2Filters.chebyone, "Chebyshev Type I", 100, 7999, 8, 16000);
chebytwo_bands = phase2(signal, @phase2Filters.chebytwo, "Chebyshev Type II", 100, 7999, 8, 16000);
elliptic_bands = phase2(signal, @phase2Filters.elliptic, "Elliptic", 100, 7999, 8, 16000);