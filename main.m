clear; clc; close all;

% inputFile = "Audio Track 4.mp3";
inputFile = "track3.mp3";
monoFile = "track3-mono.mp3";
outputFile = "track3-out.mp3";
sampleRate = 16000;
numBands = 24;

tic
signal = phase1(inputFile, monoFile, sampleRate);

% Uncomment to produce lowest and highest frequency bands for each section
% [bands, band_edges] = phase2(signal, @phase2Filters_BandPass.butterworth, "Butterworth", 100, 7999, -0.1, numBands, sampleRate);
% [bands, band_edges] = phase2(signal, @phase2Filters_BandPass.chebyone, "Chebyshev Type I", 100, 7999, -0.1, numBands, sampleRate);
% [bands, band_edges] = phase2(signal, @phase2Filters_BandPass.chebytwo, "Chebyshev Type II", 100, 7999, 0, numBands, sampleRate);
[bands, band_edges] = phase2(signal, @phase2Filters_BandPass.elliptic, "Elliptic", 100, 7999, -0.1, numBands, sampleRate);

% manual spacing
% numBands = 18;
% band_edges = [100, 156, 276, 410, 560, 730, 922, 1138, 1380, 1653, 1960, 2305, 2694, 3131, 3623, 4176, 4798, 5498, 7999];

% outputSound = phase3(butterworth_bands, numBands, butterworth_band_edges, sampleRate, outputFile);
outputSound = phase3(bands, numBands, band_edges, sampleRate, outputFile);
toc