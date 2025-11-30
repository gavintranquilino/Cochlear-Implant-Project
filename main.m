clear; clc; close all;

% inputFile = "Audio Track 4.mp3";
inputFile = "track2.mp3";
monoFile = "track2-mono.mp3";
outputFile = "track2-out.mp3";
sampleRate = 16000;
numBands = 24;

tic
signal = phase1(inputFile, monoFile, sampleRate);

% Uncomment to produce lowest and highest frequency bands for each section
% [butterworth_bands, butterworth_band_edges] = phase2(signal, @phase2Filters_BandPass.butterworth, "Butterworth", 100, 7999, numBands, sampleRate);
[chebyone_bands, chebyone_band_edges] = phase2(signal, @phase2Filters_BandPass.chebyone, "Chebyshev Type I", 100, 7999, numBands, sampleRate);
% chebytwo_bands = phase2(signal, @phase2Filters.chebytwo, "Chebyshev Type II", 100, 7999, numBands, sampleRate);
% elliptic_bands = phase2(signal, @phase2Filters.elliptic, "Elliptic", 100, 7999, numBands, sampleRate);

% outputSound = phase3(butterworth_bands, numBands, butterworth_band_edges, sampleRate, outputFile);
outputSound = phase3(chebyone_bands, numBands, chebyone_band_edges, sampleRate, outputFile);
toc