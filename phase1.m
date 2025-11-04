clear; clc; close

% PHASE 1
function signal = file2Signal(inFile, outFile, sampleRate) 
    [y, Fs] = audioread(inFile); % y is the actual audio, Fs is sampling

    sizeOfY = size(y);
    
    if (sizeOfY(:,2) == 2)
        disp(inFile + " is stereo")
        y = y(:,1) + y(:,2); % if stereo, add columns to make mono
        disp(inFile + " is now mono")
    else
        disp(inFile + " is mono")
    end
    
    disp(inFile + " is " + Fs + " Hz")
    
    audiowrite(outFile, y, Fs)

    % downsampling
    signal = resample(y, sampleRate, Fs);

    % % PHASE 2
    % % Task 4: exponentially space the edges of each band's channel
    % N = 8;
    % f_low = 100;
    % f_high = 7999;

    % band_edges = logspace(log10(f_low), log10(f_high), N+1); 

    % % Task 5: apply the filter 
    % bands = zeros(size(signal, 1), N);
    % for i = 1:1:N
    %     disp(i)
    %     [b, a] = butter(5, [band_edges(i) band_edges(i+1)]/(sampleRate/2)); % coefficients of transfer function
    %     bands(:, i) = filter(b, a, signal);
    % end

    % % Task 6: Plot lowest and highest frequency channels
    % subplot(2, 2, 1); plot(bands(:, 1));
    % title("Lowest Frequency Channel");
    % subplot(2, 2, 2); plot(bands(:, N));
    % title("Highest Frequency Channel");

    % % Task 7
    % bands = abs(bands);
    
    % % Task 8
    % [b, a] = butter(5, 400/(sampleRate/2));    

    % new_bands = zeros(size(signal));

    % for i = 1:1:N
    %     disp(i)
    %     bands(:, i) = filter(b, a, bands(:, i));
    % end

    % % Task 9: plot lowest and highest frequency channels
    % subplot(2, 2, 3); plot(bands(:, 1));
    % title("Lowest Frequency Channel (enveloped)");
    % subplot(2, 2, 4); plot(bands(:, N));
    % title("Highest Frequency Channel (enveloped)");

    % % new_bands = sum(bands, 2);

    % new_bands = bands(:, 2) + bands(:, 3) + bands(:, 4) + bands(:, 5) + bands(:, 6) + bands(:, 7);
    % subplot(2, 2, 4); plot(new_bands);
    % player = audioplayer(new_bands, sampleRate);
    % playblocking(player);

    %{ 
    % ========= END OF PHASE 1 USING AND PLOTTING COSINE 
    % plotting 

    subplot(1, 2, 1); plot(signal);
    title("Downsampled Input Audio");

    % make cosine
    n = [0 : 1 : sizeOfY(:,1)];
    cosine = cos((2 * pi * 1000) .* (n ./ Fs));

    subplot(1, 2, 2);
    plot(cosine);
    xlim([0,2*Fs/1000]);
    title("Cosine Wave");

    % audio
    player = audioplayer(signal, sampleRate);
    playblocking(player);
    
    sound(cosine, Fs);
    %}

end

% PHASE 2
function bands = filterSignal(inSignal, lowFreq, highFreq, numBands, sampleRate)
    % Task 4: exponentially space the edges of each band's channel
    band_edges = logspace(log10(lowFreq), log10(highFreq), numBands+1); 

    % Task 5: apply the filter 
    bands = zeros(size(inSignal, 1), numBands);
    for i = 1:1:numBands
        % disp(i)
        [b, a] = butter(5, [band_edges(i) band_edges(i+1)]/(sampleRate/2)); % coefficients of transfer function
        bands(:, i) = filter(b, a, inSignal);
    end

    % Task 6: Plot lowest and highest frequency channels
    subplot(2, 2, 1); plot(bands(:, 1));
    title("Lowest Frequency Channel");
    subplot(2, 2, 2); plot(bands(:, numBands));
    title("Highest Frequency Channel");

    % Task 7
    bands = abs(bands);
    
    % Task 8
    [b, a] = butter(5, 400/(sampleRate/2));
    for i = 1:1:numBands
        % disp(i)
        bands(:, i) = filter(b, a, bands(:, i));
    end

    % Task 9: plot lowest and highest frequency channels
    subplot(2, 2, 3); plot(bands(:, 1));
    title("Lowest Frequency Channel (enveloped)");
    subplot(2, 2, 4); plot(bands(:, numBands));
    title("Highest Frequency Channel (enveloped)");

    % Testing filter output by summing up post-envelop-detection/filtered signals together
    % new_bands = bands(:, 2) + bands(:, 3) + bands(:, 4) + bands(:, 5) + bands(:, 6) + bands(:, 7);
    new_bands = sum(bands, 2);
    % hold off;

    % plot(new_bands);
    player = audioplayer(new_bands, sampleRate);
    playblocking(player);
end

% inputFile = "Audio Track 4.mp3";
inputFile = "track2.mp3";
outputFile = "track2-mono.mp3";

signal = file2Signal(inputFile, outputFile, 16000);
bands = filterSignal(signal, 100, 7999, 8, 16000);
