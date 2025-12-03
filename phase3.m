% PHASE 3

function outputSound = phase3(bands, numBands, band_edges, sampleRate, outFile) 
    % Tasks 10 and 11
    central_freqs = zeros(1, numBands);
    modulated_bands = zeros(size(bands, 1), numBands);
    
    for i = 1:1:numBands
        % Task 10: Generate cosine waves of central frequencies
        central_freqs(i) = sqrt(band_edges(i)*band_edges(i+1)); % calculate geometric mean of each band
        
        % Task 11:
        n = transpose(1:1:size(bands, 1)) / sampleRate;
        
        modulated_bands(:, i) = cos((2 * pi * central_freqs(i)) .* n) .* bands(:, i);
    end

    % Task 12: Sum amplitude modulated bands to create output signal
    outputSound = sum(modulated_bands, 2);
    maxOutput = max(outputSound);
    outputSound = outputSound / maxOutput;
    
    
    % Task 13: Write audio file
    audiowrite(outFile, outputSound, sampleRate);
    player = audioplayer(outputSound, sampleRate);
    playblocking(player);
    sound(outputSound, sampleRate);
end